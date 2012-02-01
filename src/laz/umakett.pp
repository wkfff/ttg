{ -*- mode: Delphi -*- }
unit UMakeTT;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, MTProcs, UTTModel, DMaster, USolver, UModel, UTTGBasics,
    UDownHill;

type

  { TMakeTimeTableThread }

  TMakeTimeTableThread = class(TThread)
  private
    FTimeTableModel: TTimeTableModel;
    FValidIdes: TDynamicIntegerArray;
    procedure Parallel(Index: PtrInt; Data: Pointer; Item: TMultiThreadProcItem);
    function ProcessTimeTable(AIdTimeTable: Integer): Boolean;
  public
  procedure Execute; override;
  constructor Create(const AValidIdes: TDynamicIntegerArray; CreateSuspended: Boolean);
  destructor Destroy; override;
  end;

  { TImproveTimeTableThread }

  TImproveTimeTableThread = class(TThread)
  private
    FTimeTableModel: TTimeTableModel;
    FIdTimeTableFuente, FIdTimeTable: Integer;
  public
  procedure Execute; override;
  constructor Create(AIdTimeTableFuente, AIdTimeTable: Integer; CreateSuspended: Boolean);
  destructor Destroy; override;
  end;

implementation

uses UEvolElitist, FProgress, UTTGConsts;

type

  { TSyncSaver }

  TSyncSaver = class
  private
    FSolver: TSolver;
    FIdTimeTable: Integer;
    FExtraInfo: string;
    FTimeIni: TDateTime;
    FTimeEnd: TDateTime;
  public
    constructor Create(ASolver: TSolver; AIdTimeTable: Integer;
      const AExtraInfo: string; ATimeIni, ATimeEnd: TDateTime);
    procedure Execute;
  end;

{ TSyncSaver }

constructor TSyncSaver.Create(ASolver: TSolver; AIdTimeTable: Integer;
  const AExtraInfo: string; ATimeIni, ATimeEnd: TDateTime);
begin
  inherited Create;
  FSolver := ASolver;
  FIdTimeTable := AIdTimeTable;
  FExtraInfo := AExtraInfo;
  FTimeIni := ATimeIni;
  FTimeEnd := ATimeEnd;
end;

procedure TSyncSaver.Execute;
begin
  FSolver.SaveSolutionToDatabase(FIdTimeTable, FExtraInfo, FTimeIni,
    FTimeEnd);
end;

const
  FBoolToStr: array [Boolean] of string = ('No', 'Si');

procedure LoadBookmarks(s: string; Individual: TIndividual;
    ClassCant: Integer; out Bookmarks: TBookmarkArray);
var
  Pos, d, i: Integer;
begin
  Pos := 1;
  SetLength(Bookmarks, Length(s));
  i := 0;
  while Pos <= Length(s) do
  begin
    d := StrToInt(ExtractString(s, Pos, ','));
    case d of
    1: Bookmarks[i] := TTTBookmark.Create(Individual, RandomIndexes(ClassCant));
    2: Bookmarks[i] := TTTBookmark2.Create(Individual, RandomIndexes(ClassCant));
    end;
    Inc(i);
  end;
  SetLength(Bookmarks, i);
end;

procedure ExecuteDownHill(DownHill: TDownHill; const Bookmarks: string;
    RefreshInterval: Integer);
var
  i: Integer;
  Individual: TIndividual;
  BookmarkArray: TBookmarkArray;
begin
  with TTimeTableModel(DownHill.Model) do
  begin
    Individual := DownHill.Model.NewIndividual;
    try
      Individual.Assign(DownHill.BestIndividual);
      LoadBookmarks(Bookmarks, Individual, ClassCant, BookmarkArray);
      try
        TDownHill.MultiDownHill(DownHill, Individual, BookmarkArray,
                                False, RefreshInterval);
      finally
        for i := 0 to High(BookmarkArray) do
          BookmarkArray[i].Free;
      end;
    finally
      Individual.Free;
    end;
  end;
end;

function TMakeTimeTableThread.ProcessTimeTable(AIdTimeTable: Integer): Boolean;
var
  VEvolElitist: TEvolElitist;
  DownHill: TDownHill;
  FTimeIni: TDateTime;
  ProgressFormDrv: TProgressFormDrv;
  ExtraInfo: string;
begin
  Result := False;
  FTimeIni := Now;
  with MasterDataModule.ConfigStorage do
  begin
    VEvolElitist := TEvolElitist.Create(FTimeTableModel, SharedDirectory,
      PollinationProb, PopulationSize, MaxIteration, CrossProb, MutationProb,
      RepairProb, TimeTableIni);
    try
      TThread.Synchronize(CurrentThread, VEvolElitist.Initialize);
      ProgressFormDrv := TProgressFormDrv.Create;
      try
        {VEvolElitist.OnRecordBest := MainForm.OnRegistrarMejor;}
        ProgressFormDrv.Caption := Format(SWorkInProgress, [AIdTimeTable]);
        VEvolElitist.OnProgress := ProgressFormDrv.OnProgress;
        VEvolElitist.Execute(RefreshInterval);
        if ProgressFormDrv.CancelClick then
        begin
          Result := True;
          Exit;
        end;
        if ApplyDoubleDownHill then
        begin
          DownHill := TDownHill.Create(FTimeTableModel,
            SharedDirectory, PollinationProb);
          try
            DownHill.BestIndividual.Assign(VEvolElitist.BestIndividual);
            ProgressFormDrv.Caption := Format(SImprovingTimeTable, [AIdTimeTable]);
            DownHill.OnProgress := ProgressFormDrv.OnProgress;
            ExecuteDownHill(DownHill, Bookmarks, RefreshInterval);
            if ProgressFormDrv.CancelClick then
            begin
              Result := True;
              Exit;
            end;
            VEvolElitist.BestIndividual.Assign(DownHill.BestIndividual);
          finally
            DownHill.Free;
          end;
        end
        else
        begin
          VEvolElitist.DownHill;
        end;
      finally
        ProgressFormDrv.Free;
      end;
      VEvolElitist.BestIndividual.Update;
      ExtraInfo := Format(SApplyDownHill, [FBoolToStr[ApplyDoubleDownHill]]);
      with TSyncSaver.Create(VEvolElitist, AIdTimeTable, ExtraInfo,
        FTimeIni, Now) do
      try
        TThread.Synchronize(CurrentThread, Execute);
      finally
        Free;
      end;
    finally
      VEvolElitist.Free;
    end;
  end;
end;

{ TMakeTimeTableThread }

procedure TMakeTimeTableThread.Parallel(Index: PtrInt; Data: Pointer;
  Item: TMultiThreadProcItem);
begin
  MasterDataModule.ConfigStorage.InitRandom;
  if ProcessTimeTable(FValidIdes[Index]) then
    Terminate;
end;

procedure TMakeTimeTableThread.Execute;
begin
  ProcThreadPool.DoParallel(Parallel, 0, High(FValidIdes), nil);
end;

constructor TMakeTimeTableThread.Create(const AValidIdes: TDynamicIntegerArray;
  CreateSuspended: Boolean);
var
  i: Integer;
begin
  FreeOnTerminate := True;
  with MasterDataModule.ConfigStorage do
    FTimeTableModel := TTimeTableModel.Create(ClashTeacher,
      ClashSubject, ClashRoomType, TeacherFraccionamiento, OutOfPositionEmptyHour,
      BrokenSession, NonScatteredSubject);
  SetLength(FValidIdes, Length(AValidIdes));
  // ProcThreadPool.MaxThreadCount := Length(AValidIdes);
  for i := 0 to High(AValidIdes) do
    FValidIdes[i] := AValidIdes[i];
  inherited Create(CreateSuspended);
end;

destructor TMakeTimeTableThread.Destroy;
begin
  FTimeTableModel.Free;
  inherited Destroy;
end;

type

  { TSyncLoader }

  TSyncLoader = class
  private
    FIndividual: TIndividual;
    FIndex: Integer;
  public
    constructor Create(AIndividual: TIndividual; AIndex: Integer);
    procedure Execute;
  end;

{ TSyncLoader }

constructor TSyncLoader.Create(AIndividual: TIndividual; AIndex: Integer);
begin
  inherited Create;
  FIndividual := AIndividual;
  FIndex := AIndex;
end;

procedure TSyncLoader.Execute;
begin
  FIndividual.LoadFromDataModule(FIndex);
end;

{ TImproveTimeTableThread }

procedure TImproveTimeTableThread.Execute;
var
  ProgressFormDrv: TProgressFormDrv;
  TimeIni: TDateTime;
  DownHill: TDownHill;
  ExtraInfo: string;
begin
  TimeIni := Now;
  with MasterDataModule.ConfigStorage do
  begin
    InitRandom;
    DownHill := TDownHill.Create(FTimeTableModel,
      SharedDirectory, PollinationProb);
    try
      {if s = '' then
        TimeTable.MakeRandom
      else}
      with TSyncLoader.Create(TTimeTable(DownHill.BestIndividual),
        FIdTimeTableFuente) do
      try
        TThread.Synchronize(CurrentThread, Execute);
      finally
        Free;
      end;
      TDownHill.DownHill(DownHill.BestIndividual);
      ProgressFormDrv := TProgressFormDrv.Create;
      try
        DownHill.OnProgress := ProgressFormDrv.OnProgress;
        ProgressFormDrv.Caption := Format(SImprovingTimeTableIn,
          [FIdTimeTableFuente, FIdTimeTable]);
        ExecuteDownHill(DownHill, Bookmarks, RefreshInterval);
        if ProgressFormDrv.CancelClick then
        begin
          Terminate;
          Exit;
        end
        else
          ExtraInfo := Format(SBaseTimeTable, [FIdTimeTableFuente]);
          with TSyncSaver.Create(DownHill, FIdTimeTable, ExtraInfo,
            TimeIni, Now) do
          try
            TThread.Synchronize(CurrentThread, Execute);
          finally
            Free;
          end;
      finally
        ProgressFormDrv.Free;
      end;
    finally
      DownHill.Free;
    end;
  end;
end;

constructor TImproveTimeTableThread.Create(AIdTimeTableFuente, AIdTimeTable: Integer;
  CreateSuspended: Boolean);
begin
  FreeOnTerminate := True;
  FIdTimeTableFuente := AIdTimeTableFuente;
  FIdTimeTable := AIdTimeTable;
  with MasterDataModule.ConfigStorage do
    FTimeTableModel := TTimeTableModel.Create(ClashTeacher,
      ClashSubject, ClashRoomType, TeacherFraccionamiento, OutOfPositionEmptyHour,
      BrokenSession, NonScatteredSubject);
  inherited Create(CreateSuspended);
end;

destructor TImproveTimeTableThread.Destroy;
begin
  FTimeTableModel.Free;
  inherited Destroy;
end;

end.

