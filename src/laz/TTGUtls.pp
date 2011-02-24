unit TTGUtls;

{$I ttg.inc}

interface

uses
  Classes, Forms, Db, FCrsMMEd, FCrsMMER, FMasDeEd, DSource, ActnList;

function ComposicionADuracion(const s: string): Integer;
procedure LoadHints(ACrossManyToManyEditorForm: TCrossManyToManyEditorForm;
  AColDataSet, ARowDataSet, ARelDataSet: TDataSet); overload;
procedure LoadHints(ACrossManyToManyEditorForm: TCrossManyToManyEditorRForm;
  AColDataSet, ARowDataSet, ALstDataSet, ARelDataSet: TDataSet); overload;
{procedure LoadHints(ACrossManyToManyEditorForm: TFCubicalEditor2; AColDataSet,
  ARowDataSet, ALstDataSet, ARelDataSet: TTable); overload;}
procedure CrossBatchMove(AColDataSet, ARowDataSet, ARelDataSet, ADestination:
  TDataSet; const AColFieldKey, AColFieldName, AColField, ARowFieldsKey,
  ARowFieldName, ARowFields, ARelFieldKey: string);
function ExtractString(const Strings: string; var Pos: Integer; Separator:
  Char): string;

implementation

uses
  SysUtils, DMaster;

procedure LoadHints(ACrossManyToManyEditorForm: TCrossManyToManyEditorForm;
  AColDataSet, ARowDataSet, ARelDataSet: TDataSet);
begin
  with SourceDataModule, ACrossManyToManyEditorForm do
  begin
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[ARelDataSet], Description[AColDataSet],
      Description[ARowDataSet]]);
  end;
end;

procedure LoadHints(ACrossManyToManyEditorForm: TCrossManyToManyEditorRForm;
  AColDataSet, ARowDataSet, ALstDataSet, ARelDataSet: TDataSet);
begin
  with SourceDataModule, ACrossManyToManyEditorForm do
  begin
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[ARelDataSet], Description[AColDataSet],
      Description[ARowDataSet]]);
    ListBox.Hint := Format('%s|%s', [ALstDataSet.Name,
      Description[ALstDataSet]]);
  end;
end;

(*
procedure LoadHints(ACrossManyToManyEditorForm: TFCubicalEditor2; AColDataSet,
  ARowDataSet, ALstDataSet, ARelDataSet: TTable);
begin
  with MasterDataModule, ACrossManyToManyEditorForm do
  begin
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [GetDescription(ARelDataSet), GetDescription(AColDataSet),
      GetDescription(ARowDataSet)]);
    CheckListBox.Hint := Format('%s|%s', [ALstDataSet.Name,
      GetDescription(ALstDataSet)]);
  end;
end;
*)

function ExtractString(const Strings: string; var Pos: Integer; Separator:
  Char): string;
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(Strings)) and (Strings[I] <> Separator) do Inc(I);
  Result := Trim(Copy(Strings, Pos, I - Pos));
  if (I <= Length(Strings)) and (Strings[I] = Separator) then Inc(I);
  Pos := I;
end;

function ComposicionADuracion(const s: string): Integer;
var
  VPos, d: Integer;
begin
  VPos := 1;
  Result := 0;
  while VPos <= Length(s) do
  begin
    d := StrToInt(ExtractString(s, VPos, '.'));
    if d <= 0 then
      raise Exception.Create('Composicion Erroea');
    Inc(Result, d);
  end;
end;
			   
procedure CrossBatchMove(AColDataSet, ARowDataSet, ARelDataSet, ADestination:
  TDataSet; const AColFieldKey, AColFieldName, AColField, ARowFieldsKey,
  ARowFieldName, ARowFields, ARelFieldKey: string);
var
  vColFieldName, vColField, vRowFieldKey, vRowFieldName, vRelFieldKey: TField;
  iPos, i, iCountRowField: Integer;
  vField: TField;
  bColDataSetActive, bRowDataSetActive, bRelDataSetActive: Boolean;
begin
  bColDataSetActive := AColDataSet.Active;
  bRowDataSetActive := ARowDataSet.Active;
  bRelDataSetActive := ARelDataSet.Active;
  try
    AColDataSet.First;
    ARowDataSet.First;
    ARelDataSet.First;
    vColFieldName := AColDataSet.FindField(AColFieldName);
    vColField := ARelDataSet.FindField(AColField);
    vRowFieldName := ARowDataSet.FindField(ARowFieldName);
    vRelFieldKey := ARelDataSet.FindField(ARelFieldKey);
    with ADestination do
    begin
      Close;
      Fields.Clear;
      iPos := 1;
      iCountRowField := 0;
      while iPos <= Length(ARowFieldsKey) do
      begin
        vRowFieldKey := ARowDataSet.FindField(ExtractFieldName(ARowFieldsKey,
          iPos));
        vField := TFieldClass(vRowFieldKey.ClassType).Create(ADestination);
        with vField do
        begin
          FieldName := vRowFieldKey.FieldName;
          DisplayLabel := vRowFieldKey.DisplayName;
          DisplayWidth := vRowFieldKey.DisplayWidth;
          Size := vRowFieldKey.Size;
          Required := true;
          DataSet := ADestination;
        end;
        Inc(iCountRowField);
      end;
      vField := TFieldClass(vRowFieldName.ClassType).Create(ADestination);
      with vField do
      begin
        FieldName := vRowFieldName.FieldName;
        DisplayLabel := vRowFieldName.DisplayLabel;
        DisplayWidth := vRowFieldName.DisplayWidth;
        Size := vRowFieldName.Size;
        Required := true;
        DataSet := ADestination;
      end;
      AColDataSet.First;
      while not AColDataSet.Eof do
      begin
        vField := TFieldClass(vRelFieldKey.ClassType).Create(ADestination);
        with vField do
        begin
          FieldName := vColFieldName.AsString;
          DisplayWidth := vRelFieldKey.DisplayWidth;
          Size := vRelFieldKey.Size;
          Required := False;
          DataSet := ADestination;
        end;
        AColDataSet.Next;
      end;
      ARowDataSet.First;
      if not Active then
        Open else
        First;
      Fields[0].Visible := false;
      i := 0;
      while i < iCountRowField do
      begin
        Fields[i].Visible := false;
        Inc(i);
      end;
      while not ARowDataSet.Eof do
      begin
        Append;
        iPos := 1;
        i := 0;
        while iPos <= Length(ARowFieldsKey) do
        begin
          Fields[i].Value :=
            ARowDataSet.FindField(ExtractFieldName(ARowFieldsKey,
            iPos)).Value;
          Inc(i);
        end;
        Fields[i].Value := vRowFieldName.Value;
        ARowDataSet.Next;
      end;
      ARelDataSet.First;
      while not ARelDataSet.Eof do
      begin
        if Locate(ARowFieldsKey, ARelDataSet.FieldValues[ARowFields], []) then
        begin
          Edit;
          FindField(AColDataSet.Lookup(AColFieldKey, vColField.Value,
            AColFieldName)).Value := vRelFieldKey.Value;
          Post;
        end;
        ARelDataSet.Next;
      end;
    end;
  finally
    AColDataSet.Active := bColDataSetActive;
    ARowDataSet.Active := bRowDataSetActive;
    ARelDataSet.Active := bRelDataSetActive;
  end;
end;

end.
