unit RelUtils;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DbUtils, kbmMemTable;

type ERelationUtils = class(Exception);

function GetOldFieldValues(ADataSet: TDataSet; const AFieldNames: string): Variant;
procedure CheckMasterRelationUpdate(AMaster: TDataSet; ADetail: TKbmMemTable;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
procedure CheckMasterRelationDelete(AMaster: TDataSet; ADetail: TKbmMemTable;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
procedure CheckDetailRelation(AMaster, ADetail: TDataSet;
  const AMasterFields, ADetailFields: string);

function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string; AProblem: TDataSet): Boolean; overload;
function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string): Boolean; overload;
procedure doErrorRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string);

var
  StopCheckRelations: Boolean = False;

implementation

function GetOldFieldValues(ADataSet: TDataSet; const AFieldNames: string): Variant;
var
  I: Integer;
  Fields: TList;
begin
  if Pos(';', AFieldNames) <> 0 then
  begin
    Fields := TList.Create;
    try
      ADataSet.GetFieldList(Fields, AFieldNames);
      Result := VarArrayCreate([0, Fields.Count - 1], varVariant);
      for I := 0 to Fields.Count - 1 do
        Result[I] := TField(Fields[I]).OldValue;
    finally
      Fields.Free;
    end;
  end else
    Result := ADataSet.FieldByName(AFieldNames).OldValue
end;

function CompareField(Field: TField; Value: Variant): Boolean;
var
  S: string;
begin
  if Field.DataType = ftString then begin
    S := Field.AsString;
    Result := AnsiCompareStr(S, Value) = 0;
  end
  else Result := (Field.Value = Value);
end;

function CompareRecord(Fields: TList; KeyValue: Variant): Boolean;
var
  I: Integer;
  FieldCount: Integer;
begin
  FieldCount := Fields.Count;
  if FieldCount = 1 then
    Result := CompareField(TField(Fields.First), KeyValue)
  else begin
    Result := True;
    for I := 0 to FieldCount - 1 do
      Result := Result and CompareField(TField(Fields[I]), KeyValue[I]);
  end;
end;

procedure CheckMasterRelationUpdate(AMaster: TDataSet; ADetail: TkbmMemTable;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
var
  vo, vn: Variant;
  bBookmark: TBookmark;
  OldIndexFieldNames: string;
  VFields: TList;
begin
  if not StopCheckRelations then
    with ADetail do
      if not(Eof and Bof) then
      begin
        StopCheckRelations := True;
        DisableControls;
        VFields := TList.Create;
        try
          GetFieldList(VFields, ADetailFields);
          vo := GetOldFieldValues(AMaster, AMasterFields);
          vn := AMaster.FieldValues[AMasterFields];
          if not CompareRecord(VFields, vo) then
          begin
            CheckBrowseMode;
            bBookmark := GetBookmark;
            try
              try
                OldIndexFieldNames := IndexFieldNames;
                IndexFieldNames := ADetailFields;
                try
                  if Locate(ADetailFields, vo, []) then
                  begin
                    if ACascade then
                    begin
                      repeat
                        Edit;
                        FieldValues[ADetailFields] := vn;
                        Post;
                        Next;
                      until not CompareRecord(VFields, vo);
                    end
                    else
                      raise ERelationUtils.CreateFmt('Ya existen campos relacionados en la tabla %s', [Name]);
                  end;
                finally
                  IndexFieldNames := OldIndexFieldNames;
                end;
              finally
                try
                  if BookmarkValid(bBookmark) then
                    GotoBookmark(bBookmark);
                except
                end;
              end;
            finally
              FreeBookmark(bBookmark);
            end;
          end;
        finally
          StopCheckRelations := False;
          EnableControls;
          VFields.Free;
        end;
      end;
end;

procedure CheckMasterRelationDelete(AMaster: TDataSet; ADetail: TKbmMemTable;
  const AMasterFields, ADetailFields: string; ACascade: Boolean);
var
  vo: Variant;
  bBookmark: TBookmark;
  OldIndexFieldNames: string;
  VFields: TList;
begin
  if not StopCheckRelations then
    with ADetail do
      if not(Eof and Bof) then
      begin
        StopCheckRelations := True;
        DisableControls;
        VFields := TList.Create;
        try
          GetFieldList(VFields, ADetailFields);
          vo := GetOldFieldValues(AMaster, AMasterFields);
          bBookmark := GetBookmark;
          try
            try
              OldIndexFieldNames := IndexFieldNames;
              IndexFieldNames := ADetailFields;
              try
                if Locate(ADetailFields, vo, []) then
                begin
                  if ACascade then
                  begin
                  // Se puede optimizar
                    repeat
                      Delete;
                    until not CompareRecord(VFields, vo);
                  end
                  else
                    raise ERelationUtils.CreateFmt('Ya existen registros detalle en la tabla %s', [Name]);
                end;
              finally
                IndexFieldNames := OldIndexFieldNames;
              end;
            finally
              try
                if BookmarkValid(bBookmark) then
                  GotoBookmark(bBookmark);
              except
              end;
            end;
          finally
            FreeBookmark(bBookmark);
          end;
        finally
          StopCheckRelations := False;
          EnableControls;
          VFields.Free;
        end;
      end;
end;

procedure CheckDetailRelation(AMaster, ADetail: TDataSet;
  const AMasterFields, ADetailFields: string);
var
  bBookmark: TBookmark;
begin
  if not StopCheckRelations then
    with AMaster do
    if RecordCount > 0 then
    begin
      StopCheckRelations := True;
      DisableControls;
      try
        bBookmark := GetBookmark;
        try
          try
            if not Locate(AMasterFields, ADetail.FieldValues[ADetailFields], []) then
              raise ERelationUtils.CreateFmt('No existe registro maestro en la tabla %s', [AMaster.Name]);
          finally
            try
              if Assigned(bBookmark) and BookmarkValid(bBookmark) then
                GotoBookmark(bBookmark);
            except
            end;
          end;
        finally
          FreeBookmark(bBookmark);
        end;
      finally
        StopCheckRelations := False;
        EnableControls;
      end;
    end;
end;

//Retorna verdadero si hubo problemas

function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string;
  AProblem: TDataSet): Boolean;
var
  v: Variant;
  s: string;
  i: Integer;
begin
  Result := False;
  if not StopCheckRelations then
    with ADetail do
    begin
      StopCheckRelations := True;
      DisableControls;
      if AProblem.FieldCount = 0 then
        AProblem.FieldDefs.Assign(ADetail.FieldDefs);
      s := '';
      for i := 0 to AProblem.FieldDefs.Count - 1 do
      begin
        if s = '' then
          s := AProblem.FieldDefs[i].Name
        else
          s := s + ';' + AProblem.FieldDefs[i].Name;
      end;
      try
        First;
        while not Eof do
        begin
          v := FieldValues[ADetailFields];
          if not AMaster.Locate(AMasterFields, v, []) then
          begin
            AProblem.Append;
            AProblem.FieldValues[s] := FieldValues[s];
            Result := True;
          end;
          Next;
        end;
      finally
        StopCheckRelations := False;
        EnableControls;
      end;
    end;
end;

function CheckRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string): Boolean;
var
  v: Variant;
begin
  Result := False;
  if not StopCheckRelations then
    with ADetail do
    begin
      StopCheckRelations := True;
      DisableControls;
      try
        First;
        while not Eof do
        begin
          v := FieldValues[ADetailFields];
          if not AMaster.Locate(AMasterFields, v, []) then
          begin
            Result := True;
            Exit;
          end;
          Next;
        end;
      finally
        StopCheckRelations := False;
        EnableControls;
      end;
    end;
end;

procedure doErrorRelation(AMaster, ADetail: TDataSet; const AMasterFields, ADetailFields: string);
begin
  if CheckRelation(AMaster, ADetail, AMasterFields, ADetailFields) then
    raise ERelationUtils.CreateFmt('Error verificando relaci�n entre %s y %s.  Campos detallados no tienen maestro', [AMaster.Name, ADetail.Name]);
end;

end.

