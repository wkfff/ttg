{ -*- mode: Delphi -*- }
unit UMakeTT;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, UTTModel, UTTGConfig, USolver, UModel, UTTGBasics, UDownHill,
  UProgress;

type

  { TMakeTimetableThread }

  TMakeTimetableThread = class(TThread)
  private
    FTimetableModel: TTimetableModel;
    FValidIds: TDynamicIntegerArray;
    FTTGConfig: TTTGConfig;
    FProgressViewer: TProgressViewer;
    function ProcessTimetable(AIdTimetable, ATimetable: Integer;
      AProgressViewer: TProgressViewer): Boolean;
  public
  procedure Execute; override;
  constructor Create(const AValidIds: TDynamicIntegerArray; ATTGConfig: TTTGConfig;
    AProgressViewer: TProgressViewer; CreateSuspended: Boolean);
  destructor Destroy; override;
  end;

  { TImproveTimetableThread }

  TImproveTimetableThread = class(TThread)
  private
    FTimetableModel: TTimetableModel;
    FIdTimetableSource, FIdTimetable: Integer;
    FTTGConfig: TTTGConfig;
    FProgressViewer: TProgressViewer;
  public
  procedure Execute; override;
  constructor Create(AIdTimetableFuente, AIdTimetable: Integer;
    ATTGConfig: TTTGConfig; AProgressViewer: TProgressViewer; CreateSuspended: Boolean);
  destructor Destroy; override;
  end;

implementation

uses
  UEvolElitist, UTTGConsts;

type

  { TSyncSaver }

  TSyncSaver = class
  private
    FSolver: TSolver;
    FIdTimetable: Integer;
    FExtraInfo: string;
    FTimeIni: TDateTime;
    FTimeEnd: TDateTime;
  public
    constructor Create(ASolver: TSolver; AIdTimetable: Integer;
      const AExtraInfo: string; ATimeIni, ATimeEnd: TDateTime);
    procedure Execute;
  end;

{ TSyncSaver }

constructor TSyncSaver.Create(ASolver: TSolver; AIdTimetable: Integer;
  const AExtraInfo: string; ATimeIni, ATimeEnd: TDateTime);
begin
  inherited Create;
  FSolver := ASolver;
  FIdTimetable := AIdTimetable;
  FExtraInfo := AExtraInfo;
  FTimeIni := ATimeIni;
  FTimeEnd := ATimeEnd;
end;

procedure TSyncSaver.Execute;
begin
  FSolver.SaveSolutionToDatabase(FIdTimetable, FExtraInfo, FTimeIni,
    FTimeEnd);
end;

procedure LoadBookmarks(s: string; Individual: TIndividual; out Bookmarks: TBookmarkArray);
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
    1: Bookmarks[i] := TTTBookmark1.Create(TTimetable(Individual));
    2: Bookmarks[i] := TTTBookmark2.Create(TTimetable(Individual));
    3: Bookmarks[i] := TTTBookmark3.Create(TTimetable(Individual));
    4: Bookmarks[i] := TTTBookmarkTheme.Create(TTimetable(Individual));
    end;
    Inc(i);
  end;
  SetLength(Bookmarks, i);
end;

procedure ExecuteDownHill(DownHill: TDownHill; const Bookmarks: string);
var
  i: Integer;
  Individual: TIndividual;
  BookmarkArray: TBookmarkArray;
begin
  with TTimetableModel(DownHill.Model) do
  begin
    Individual := DownHill.Model.NewIndividual;
    try
      Individual.Assign(DownHill.BestIndividual);
      LoadBookmarks(Bookmarks, Individual, BookmarkArray);
      try
        TDownHill.MultiDownHill(DownHill, Individual, BookmarkArray, False);
      finally
        for i := 0 to High(BookmarkArray) do
          BookmarkArray[i].Free;
      end;
    finally
      Individual.Free;
    end;
  end;
end;

function TMakeTimetableThread.ProcessTimetable(AIdTimetable, ATimetable: Integer;
                                               AProgressViewer: TProgressViewer): Boolean;
var
  EvolElitist: TEvolElitist;
  DownHill: TDownHill;
  FTimeIni: TDateTime;
  ExtraInfo: string;
  FBoolToStr: array [Boolean] of string;
begin
  Result := False;
  FTimeIni := Now;
  // We hav to initialize here due to SNo and SYes are location dependent
  FBoolToStr[False] := SNo;
  FBoolToStr[True] := SYes;
  with FTTGConfig do
  begin
    EvolElitist := TEvolElitist.Create(FTimetableModel, SharedDirectory,
      PollinationProbability, PopulationSize, MaxIteration, CrossProbability,
      MutationProbability, ReparationProbability, InitialTimetables);
    try
      Synchronize(@EvolElitist.Initialize);
      AProgressViewer.Thread := Self;
      AProgressViewer.Timetable := ATimetable;
      try
        AProgressViewer.Caption := Format(SWorkInProgress, [AIdTimetable]);
        EvolElitist.OnProgress := @AProgressViewer.OnProgress;
        EvolElitist.Execute;
        if AProgressViewer.CancelClick then
        begin
          Result := True;
          Exit;
        end;
        if not AProgressViewer.CloseClick and ApplyDoubleDownHill then
        begin
          DownHill := TDownHill.Create(FTimetableModel,
            SharedDirectory, PollinationProbability);
          try
            DownHill.BestIndividual.Assign(EvolElitist.BestIndividual);
            AProgressViewer.Caption := Format(SImprovingTimetable, [AIdTimetable]);
            DownHill.OnProgress := @AProgressViewer.OnProgress;
            ExecuteDownHill(DownHill, Bookmarks);
            if AProgressViewer.CancelClick then
            begin
              Result := True;
              Exit;
            end;
            EvolElitist.BestIndividual.Assign(DownHill.BestIndividual);
          finally
            DownHill.Free;
          end;
        end
        else
        begin
          EvolElitist.DownHill;
        end;
      finally
        AProgressViewer.Thread := nil;
      end;
      EvolElitist.BestIndividual.Update;
      ExtraInfo := Format('%0:-28s %12s',
        [SApplyDownhill + ':', FBoolToStr[ApplyDoubleDownHill]]);
      with TSyncSaver.Create(EvolElitist, AIdTimetable, ExtraInfo,
        FTimeIni, Now) do
      try
        Synchronize(@Execute);
      finally
        Free;
      end;
    finally
      EvolElitist.Free;
    end;
  end;
end;

procedure TMakeTimetableThread.Execute;
var
  ValidId: Integer;
begin
  for ValidId := 0 to High(FValidIds) do
  begin
    FTTGConfig.InitRandom;
    if ProcessTimetable(FValidIds[ValidId], ValidId, FProgressViewer) then
      Terminate;
  end;
end;

constructor TMakeTimetableThread.Create(const AValidIds: TDynamicIntegerArray;
  ATTGConfig: TTTGConfig; AProgressViewer: TProgressViewer; CreateSuspended: Boolean);
var
  i: Integer;
begin
  FreeOnTerminate := True;
  FTTGConfig := ATTGConfig;
  FProgressViewer := AProgressViewer;
  with FTTGConfig do
    FTimetableModel := TTimetableModel.Create(
      ClashActivity, BreakTimetableResource, BrokenSession, NonScatteredActivity);
  SetLength(FValidIds, Length(AValidIds));
  // ProcThreadPool.MaxThreadCount := Length(AValidIds);
  for i := 0 to High(AValidIds) do
    FValidIds[i] := AValidIds[i];
  inherited Create(CreateSuspended);
end;

destructor TMakeTimetableThread.Destroy;
begin
  FTimetableModel.Free;
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

{ TImproveTimetableThread }

procedure TImproveTimetableThread.Execute;
var
  TimeIni: TDateTime;
  DownHill: TDownHill;
  ExtraInfo: string;
begin
  TimeIni := Now;
  with FTTGConfig do
  begin
    InitRandom;
    DownHill := TDownHill.Create(FTimetableModel,
      SharedDirectory, PollinationProbability);
    try
      {if s = '' then
        Timetable.MakeRandom
      else}
      with TSyncLoader.Create(TTimetable(DownHill.BestIndividual),
        FIdTimetableSource) do
      try
        Synchronize(@Execute);
      finally
        Free;
      end;
      TDownHill.DownHill(DownHill.BestIndividual);
      DownHill.OnProgress := @FProgressViewer.OnProgress;
      FProgressViewer.Caption := Format(SImprovingTimetableIn,
        [FIdTimetableSource, FIdTimetable]);
      ExecuteDownHill(DownHill, Bookmarks);
      FProgressViewer.Thread := Self;
      if FProgressViewer.CancelClick then
      begin
        Terminate;
        Exit;
      end
      else
        ExtraInfo := Format(SBaseTimetable, [FIdTimetableSource]);
      with TSyncSaver.Create(DownHill, FIdTimetable, ExtraInfo,
        TimeIni, Now) do
      try
        Synchronize(@Execute);
      finally
        Free;
      end;
    finally
      DownHill.Free;
    end;
  end;
end;

constructor TImproveTimetableThread.Create(AIdTimetableFuente, AIdTimetable: Integer;
  ATTGConfig: TTTGConfig; AProgressViewer: TProgressViewer; CreateSuspended: Boolean);
begin
  FreeOnTerminate := True;
  FIdTimetableSource := AIdTimetableFuente;
  FIdTimetable := AIdTimetable;
  FTTGConfig := ATTGConfig;
  FProgressViewer := AProgressViewer;
  with FTTGConfig do
    FTimetableModel := TTimetableModel.Create(
      ClashActivity, BreakTimetableResource, BrokenSession, NonScatteredActivity);
  inherited Create(CreateSuspended);
end;

destructor TImproveTimetableThread.Destroy;
begin
  FTimetableModel.Free;
  FProgressViewer.Free;
  inherited Destroy;
end;

end.

