{ -*- mode: Delphi -*- }
unit UDownHill;

{$I ttg.inc}

interface

uses
  Classes, SysUtils, USolver, UModel;

type

  { TDownHill }

  TDownHill = class(TSolver)
  private
    class function MultiDownHill(Sender: TSolver; Individual: TIndividual;
      ABookmarks: TBookmarkArray; ExitOnFirstDown: Boolean;
      Level, Threshold: Integer): Integer; overload;
    function MultiDownHill(MaxLevel: Integer): Integer; overload;
    class function MultiDownHill(Sender: TSolver; Individual: TIndividual;
      MaxLevel: Integer): Integer; overload;
  protected
  public
    class function MultiDownHill(Sender: TSolver; Individual: TIndividual;
      ABookmarks: TBookmarkArray; ExitOnFirstDown: Boolean): Integer; overload;
    class function DownHill(Individual: TIndividual): Integer;
    procedure Execute; override;
    procedure SaveSolutionToDatabase(AIdTimetable: Integer;
      const AExtraInfo: string; ATimeIni, ATimeEnd: TDateTime); override;
  end;

implementation

uses
  UTTGConsts;

{ TDownHill }

class function TDownHill.DownHill(Individual: TIndividual): Integer;
begin
  Result := MultiDownHill(nil, Individual, 1);
end;

function TDownHill.MultiDownHill(MaxLevel: Integer): Integer;
var
  Individual: TIndividual;
begin
  Individual := Model.NewIndividual;
  try
    Individual.Assign(BestIndividual);
    Result := MultiDownHill(Self, Individual, MaxLevel);
  finally
    Individual.Free;
  end;
end;

class function TDownHill.MultiDownHill(Sender: TSolver; Individual: TIndividual;
    MaxLevel: Integer): Integer;
var
  Bookmarks: TBookmarkArray;
  i: Integer;
begin
  SetLength(Bookmarks, MaxLevel);
  for i := 0 to MaxLevel - 1 do
    Bookmarks[i] := Individual.NewBookmark;
  try
    Result := MultiDownHill(Sender, Individual, Bookmarks, False, 0, 0);
  finally
    for i := 0 to MaxLevel - 1 do
      Bookmarks[i].Free;
  end;
end;

class function TDownHill.MultiDownHill(Sender: TSolver; Individual: TIndividual;
    ABookmarks: TBookmarkArray; ExitOnFirstDown: Boolean): Integer;
begin
  try
    Result := MultiDownHill(Sender, Individual, ABookmarks, ExitOnFirstDown, 0, 0);
  finally
    if assigned (Sender) and (Sender.SharedDirectory <> '')
        and FileExists(Sender.FileName) then
      DeleteFile(Sender.FileName);
  end;
end;

class function TDownHill.MultiDownHill(Sender: TSolver; Individual: TIndividual;
    ABookmarks: TBookmarkArray; ExitOnFirstDown: Boolean; Level, Threshold: Integer): Integer;
var
  Delta: Integer;
  Stop, Down: Boolean;
  Bookmark: TBookmark;
begin
  with Individual do
  begin
    Result := Value;
    try
      Stop := False;
      Bookmark := ABookmarks[Level];
      Bookmark.First;
      while not Bookmark.Eof do
      begin
        Down := False;
        if Assigned(Sender) and (Level = 0) then
        begin
          Sender.DoProgress(Bookmark.Progress, Bookmark.Max, Sender, Stop);
          if Stop then
            Exit;
          if Sender.Pollinate(Individual) then
            Down := True;
        end;
        if not Down then
        begin
          Delta := Bookmark.Move;
          if Delta < Threshold then
          begin
            if ExitOnFirstDown then
              Exit;
            Threshold := 0;
            Down := True;
          end
          else
          begin
            if (Level = High(ABookmarks)) or (MultiDownHill(Sender, Individual,
              ABookmarks, True, Level + 1, Threshold - Delta) >= 0) then
              Bookmark.Undo
            else
            begin
              if ExitOnFirstDown then
                Exit;
              Threshold := 0;
              Down := True;
            end;
          end;
        end;
        Bookmark.Next;
        if Down then
        begin
          Bookmark.Rewind;
          if Assigned(Sender) then
            Sender.BestIndividual.Assign(Individual);
        end;
      end;
    finally
      Result := Value - Result;
    end;
  end;
end;

procedure TDownHill.Execute;
begin
  inherited;
  MultiDownHill(2);
end;

procedure TDownHill.SaveSolutionToDatabase(AIdTimetable: Integer;
  const AExtraInfo: string; ATimeIni, ATimeEnd: TDateTime);
var
  Report: TStrings;
begin
  Report := TStringList.Create;
  try
    Report.Add(SDownHillAlgorithm);
    Report.Add('=====================');
    if AExtraInfo <> '' then
      Report.Add(AExtraInfo);
    BestIndividual.ReportValues(Report);
    BestIndividual.SaveToDataModule(AIdTimetable, ATimeIni, ATimeEnd, Report);
  finally
    Report.Free;
  end;
end;

end.

