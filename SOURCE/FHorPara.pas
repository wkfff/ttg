unit FHorPara;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FCrsMMER, Placemnt, StdCtrls, Buttons, ExtCtrls, Grids, RXGrids, Variants,
  Db, FCrsMME1, kbmMemTable, DBCtrls, ImgList, ComCtrls, ToolWin;

type
  THorarioParaleloForm = class(TCrossManyToManyEditor1Form)
    QuHorarioParalelo: TkbmMemTable;
    BtnIntercambiarPeriodos: TToolButton;
    dlcNivel: TDBLookupComboBox;
    dlcEspecializacion: TDBLookupComboBox;
    dlcParaleloId: TDBLookupComboBox;
    cbVerParalelo: TComboBox;
    BtnMostrar: TToolButton;
    BtnPrior: TToolButton;
    BtnNext: TToolButton;
    QuHorarioParaleloCodMateria: TIntegerField;
    QuHorarioParaleloCodNivel: TIntegerField;
    QuHorarioParaleloCodEspecializacion: TIntegerField;
    QuHorarioParaleloCodParaleloId: TIntegerField;
    QuHorarioParaleloCodHora: TIntegerField;
    QuHorarioParaleloCodDia: TIntegerField;
    QuHorarioParaleloCodProfesor: TAutoIncField;
    QuHorarioParaleloNomMateria: TStringField;
    QuHorarioParaleloApeNomProfesor: TStringField;
    QuHorarioParaleloNombre: TStringField;
    dsParalelo: TDataSource;
    procedure BtnMostrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure IntercambiarPeriodosClick(Sender: TObject);
    procedure BtnPriorClick(Sender: TObject);
    procedure BtnNextClick(Sender: TObject);
    procedure QuHorarioParaleloCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    FCodHorario: Integer;
    FNombre: string;
    function GetCodNivel: Integer;
    function GetCodEspecializacion: Integer;
    function GetCodParaleloId: Integer;
    function GetCodDia: Integer;
    function GetCodHora: Integer;
    function GetNomNivel: string;
    function GetNomEspecializacion: string;
    function GetNomParaleloId: string;
    procedure FillHorarioParalelo;
  public
    { Public declarations }
    property CodHorario: Integer read FCodHorario write FCodHorario;
    property CodNivel: Integer read GetCodNivel;
    property CodEspecializacion: Integer read GetCodEspecializacion;
    property CodParaleloId: Integer read GetCodParaleloId;
    property CodDia: Integer read GetCodDia;
    property CodHora: Integer read GetCodHora;
    property NomNivel: string read GetNomNivel;
    property NomEspecializacion: string read GetNomEspecializacion;
    property NomParaleloId: string read GetNomParaleloId;
  end;

implementation
uses
  HorColCm, FSelPeIn, DSource, DMaster;
{$R *.DFM}

function THorarioParaleloForm.GetCodDia: Integer;
begin
  Result := ColKey[DrawGrid.Col - 1];
end;

function THorarioParaleloForm.GetCodHora: Integer;
begin
  Result := RowKey[DrawGrid.Row - 1];
end;

function THorarioParaleloForm.GetCodNivel: Integer;
begin
  if varIsEmpty(dlcNivel.KeyValue) then
    raise Exception.Create('Debe especificar un Nivel');
  Result := dlcNivel.KeyValue;
end;

function THorarioParaleloForm.GetCodEspecializacion: Integer;
begin
  if varIsEmpty(dlcEspecializacion.KeyValue) then
    raise Exception.Create('Debe especificar un Nivel');
  Result := dlcEspecializacion.KeyValue;
end;

function THorarioParaleloForm.GetCodParaleloId: Integer;
begin
  if varIsEmpty(dlcParaleloId.KeyValue) then
    raise Exception.Create('Debe especificar un Paralelo');
  Result := dlcParaleloId.KeyValue;
end;

function THorarioParaleloForm.GetNomNivel: string;
begin
  Result := dlcNivel.Text;
end;

function THorarioParaleloForm.GetNomEspecializacion: string;
begin
  Result := dlcEspecializacion.Text;
end;

function THorarioParaleloForm.GetNomParaleloId: string;
begin
  Result := dlcParaleloId.Text;
end;

procedure THorarioParaleloForm.BtnMostrarClick(Sender: TObject);
  procedure HorarioParalelo;
  var
    FParalelo: Variant;
    s: string;
  begin
    SourceDataModule.TbParalelo.IndexFieldNames := 'CodNivel;CodEspecializacion;CodParaleloId';
    with MasterDataModule do
    begin
      FParalelo :=
        SourceDataModule.TbParalelo.Lookup('CodNivel;CodEspecializacion;CodParaleloId',
        VarArrayOf([CodNivel, CodEspecializacion, CodParaleloId]),
        'CodNivel;CodEspecializacion;CodParaleloId');
      if VarIsNull(FParalelo) then
        raise Exception.CreateFmt('%s %s %s no es un %s v�lido',
          [NomNivel, NomEspecializacion, NomParaleloId, SourceDataModule.TbParalelo.Name]);
      s := Format('[%s %d] - %s %s %s', [SourceDataModule.TbHorario.Name, CodHorario,
        dlcNivel.Text, dlcEspecializacion.Text, dlcParaleloId.Text]);
      if QuHorarioParalelo.IsEmpty then
        raise Exception.CreateFmt('%s %s no v�lido', [s, SourceDataModule.TbParalelo.Name]);
      Caption := s;
    end;
  end;
  procedure Mostrar;
  begin
    with SourceDataModule, MasterDataModule do
    begin
      FNombre := StringsShowParalelo.Values[cbVerParalelo.Text];
      ShowEditor(TbDia, TbHora, QuHorarioParalelo, TbPeriodo,
        'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora', 'NomHora', 'CodHora',
        'CodHora', 'Nombre');
      BtnIntercambiarPeriodos.Enabled := True;
    end;
  end;
begin
  inherited;
  HorarioParalelo;
  Mostrar;
end;

procedure THorarioParaleloForm.FormCreate(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.First;
  QuHorarioParalelo.Open;
  CodHorario := SourceDataModule.TbHorarioCodHorario.Value;
  cbVerParalelo.Items.Clear;
  FillHorarioParalelo;
  LoadNames(MasterDataModule.StringsShowParalelo, cbVerParalelo.Items);
  cbVerParalelo.Text := cbVerParalelo.Items[0];
  dlcNivel.KeyValue := SourceDataModule.TbParaleloCodNivel.AsInteger;
  dlcEspecializacion.KeyValue := SourceDataModule.TbParaleloCodEspecializacion.AsInteger;
  dlcParaleloId.KeyValue := SourceDataModule.TbParaleloCodParaleloId.AsInteger;
  BtnMostrarClick(nil);
end;

procedure THorarioParaleloForm.IntercambiarPeriodosClick(Sender: TObject);
var
  iCodDia, iCodHora: Integer;
begin
  inherited;
  if SeleccionarPeriodo(iCodDia, iCodHora) then
  begin
    MasterDataModule.IntercambiarPeriodos(CodHorario, CodNivel,
      CodEspecializacion, CodParaleloId, CodDia, CodHora, iCodDia, iCodHora);
    BtnMostrarClick(nil);
  end;
end;

procedure THorarioParaleloForm.BtnPriorClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.Prior;
  dlcNivel.KeyValue := SourceDataModule.TbParaleloCodNivel.AsInteger;
  dlcEspecializacion.KeyValue := SourceDataModule.TbParaleloCodEspecializacion.AsInteger;
  dlcParaleloId.KeyValue := SourceDataModule.TbParaleloCodParaleloId.AsInteger;
  BtnMostrarClick(nil);
end;

procedure THorarioParaleloForm.BtnNextClick(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbParalelo.Next;
  dlcNivel.KeyValue := SourceDataModule.TbParaleloCodNivel.AsInteger;
  dlcEspecializacion.KeyValue := SourceDataModule.TbParaleloCodEspecializacion.AsInteger;
  dlcParaleloId.KeyValue := SourceDataModule.TbParaleloCodParaleloId.AsInteger;
  BtnMostrarClick(nil);
end;

procedure THorarioParaleloForm.FillHorarioParalelo;
var
  CodHorario, CodMateria, CodNivel, CodEspecializacion, CodParaleloId: Integer;
  s: string;
begin
  with SourceDataModule do
  begin
    QuHorarioParalelo.EmptyTable;
    CodHorario := TbHorarioCodHorario.Value;
    TbHorarioDetalle.IndexFieldNames := 'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodHora';
    if TbHorarioDetalle.Locate('CodHorario', CodHorario, []) then
    begin
      TbDistributivo.DisableControls;
      s := TbDistributivo.IndexFieldNames;
      TbDistributivo.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      TbDistributivo.First;
      QuHorarioParalelo.DisableControls;
      try
        while (TbHorarioDetalleCodHorario.Value = CodHorario) and not TbHorarioDetalle.Eof do
        begin
          CodMateria := TbHorarioDetalleCodMateria.Value;
          CodNivel := TbHorarioDetalleCodNivel.Value;
          CodEspecializacion := TbHorarioDetalleCodEspecializacion.Value;
          CodParaleloId := TbHorarioDetalleCodParaleloId.Value;
          while ((TbDistributivoCodMateria.Value <> CodMateria)
            or (TbDistributivoCodNivel.Value <> CodNivel)
            or (TbDistributivoCodEspecializacion.Value <> CodEspecializacion)
            or (TbDistributivoCodParaleloId.Value <> CodParaleloId))
            and not TbDistributivo.Eof do
            TbDistributivo.Next;
          QuHorarioParalelo.Append;
          QuHorarioParaleloCodProfesor.Value := TbDistributivoCodProfesor.Value;
          QuHorarioParaleloCodMateria.Value := CodMateria;
          QuHorarioParaleloCodNivel.Value := CodNivel;
          QuHorarioParaleloCodEspecializacion.Value := CodEspecializacion;
          QuHorarioParaleloCodParaleloId.Value := CodParaleloId;
          QuHorarioParaleloCodDia.Value := TbHorarioDetalleCodDia.Value;
          QuHorarioParaleloCodHora.Value := TbHorarioDetalleCodHora.Value;
          QuHorarioParalelo.Post;
          TbHorarioDetalle.Next;
        end;
      finally
        TbDistributivo.IndexFieldNames := s;
        TbDistributivo.EnableControls;
        QuHorarioParalelo.EnableControls;
      end;
    end;
  end;
end;

procedure THorarioParaleloForm.QuHorarioParaleloCalcFields(DataSet: TDataSet);
begin
  inherited;
  if FNombre <> '' then
    DataSet['Nombre'] := VarArrToStr(DataSet[FNombre], ' ');
end;

end.
