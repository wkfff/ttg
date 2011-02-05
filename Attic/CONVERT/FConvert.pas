unit FConvert;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ToolEdit, kbmMemTable, DB, Placemnt, Grids, DBGrids,
  DBPacker;

type
  EConvertError = class(Exception);
  TConvertForm = class(TForm)
    feSource: TFilenameEdit;
    feDestination: TFilenameEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnConvertir: TButton;
    FormStorage1: TFormStorage;
    DBGrid1: TDBGrid;
    cbxDataSet: TComboBox;
    TbAsignatura: TkbmMemTable;
    TbAsignaturaCodMateria: TIntegerField;
    TbAsignaturaCodNivel: TIntegerField;
    TbAsignaturaCodEspecializacion: TIntegerField;
    TbAsignaturaCodAulaTipo: TIntegerField;
    TbAsignaturaComposicion: TStringField;
    procedure btnConvertirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbxDataSetChange(Sender: TObject);
  private
    procedure ConvertDBP120_HPC121(ASource, ADestination: TStream); overload;
    procedure ConvertDBP120_HPC121(const ASourceFileName,
      ADestinationFileName: string); overload;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConvertForm: TConvertForm;

implementation

{$R *.DFM}
uses
  ARCConst, BZip2, DSrcBase, ArDBUtls, RelUtils;

type
  TPackerOption = (poStructure, poData, poCompress);
  TPackerOptions = set of TPackerOption;
  TPackerFileHeader = packed record
    GenHeader: array[1..4] of Char;
    VersionNumber: Integer;
    Options: TPackerOptions;
  end;

  THPCFileHeader = packed record
    GenHeader: array[1..4] of Char;
    VersionNumber: Integer;
  end;

const
  pfhPackerVersionNumber = $00000203;
  pfhHPCVersionNumber = $00000121;

procedure TConvertForm.ConvertDBP120_HPC121(ASource, ADestination: TStream);
var
  PackerFileHeader: TPackerFileHeader;
  HPCFileHeader: THPCFileHeader;
  TbMemTable: TKbmMemTable;
  procedure LoadSource(ASource, ADestination: TStream; ATable: TkbmMemTable);
  begin
    TbMemTable.Open;
    try
      LoadDataSetFromStream(TbMemTable, ASource);
      ATable.EmptyTable;
      ATable.LoadFromDataSet(TbMemTable, []);
    finally
      TbMemTable.Close;
    end;
  end;
  procedure AddFDCodAulaTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodAulaTipo';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDNomAulaTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'NomAulaTipo';
      DataType := ftString;
      Size := 25;
    end;
  end;
  procedure AddFDAbrAulaTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'AbrAulaTipo';
      DataType := ftString;
      Size := 10;
    end;
  end;
  procedure AddFDCantidad;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'Cantidad';
      DataType := ftInteger;
    end;
  end;
  procedure CargarAulaTipo(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodAulaTipo;
    AddFDNomAulaTipo;
    AddFDAbrAulaTipo;
    AddFDCantidad;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbAulaTipo);
  end;
  procedure AddFDCodEspecializacion;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodEspecializacion';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDNomEspecializacion;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'NomEspecializacion';
      DataType := ftString;
      Size := 20;
    end;
  end;
  procedure AddFDAbrEspecializacion;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'AbrEspecializacion';
      DataType := ftString;
      Size := 10;
    end;
  end;
  procedure CargarEspecializacion(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodEspecializacion;
    AddFDNomEspecializacion;
    AddFDAbrEspecializacion;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbEspecializacion);
  end;
  procedure AddFDCodNivel;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodNivel';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDNomNivel;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'NomNivel';
      DataType := ftString;
      Size := 15;
    end;
  end;
  procedure AddFDAbrNivel;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'AbrNivel';
      DataType := ftString;
      Size := 5;
    end;
  end;
  procedure CargarNivel(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodNivel;
    AddFDNomNivel;
    AddFDAbrNivel;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbNivel);
  end;
  procedure AddFDCodMateria;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodMateria';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDNomMateria;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'NomMateria';
      DataType := ftString;
      Size := 20;
    end;
  end;
  procedure CargarMateria(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodMateria;
    AddFDNomMateria;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbMateria);
  end;
  procedure AddFDCodDia;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodDia';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDNomDia;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'NomDia';
      DataType := ftString;
      Size := 10;
    end;
  end;
  procedure CargarDia(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodDia;
    AddFDNomDia;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbDia);
  end;
  procedure CargarCurso(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodNivel;
    AddFDCodEspecializacion;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbCurso);
  end;
  procedure AddFDCodHora;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodHora';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDNomHora;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'NomHora';
      DataType := ftString;
      Size := 10;
    end;
  end;
  procedure AddFDIntervalo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'Intervalo';
      DataType := ftString;
      Size := 21;
    end;
  end;
  procedure CargarHora(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodHora;
    AddFDNomHora;
    AddFDIntervalo;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbHora);
  end;
  procedure AddFDCodHorario;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodHorario';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDMomentoInicial;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'MomentoInicial';
      DataType := ftDateTime;
    end;
  end;
  procedure AddFDMomentoFinal;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'MomentoFinal';
      DataType := ftDateTime;
    end;
  end;
  procedure AddFDInforme;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'Informe';
      DataType := ftMemo;
      Size := 1;
    end;
  end;
  procedure CargarHorario(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodHorario;
    AddFDMomentoInicial;
    AddFDMomentoFinal;
    AddFDInforme;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbHorario);
  end;
  procedure AddFDComposicion;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'Composicion';
      DataType := ftString;
      Size := 20;
    end;
  end;
  procedure CargarAsignatura(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodMateria;
    AddFDCodNivel;
    AddFDCodEspecializacion;
    AddFDCodAulaTipo;
    AddFDComposicion;
    LoadSource(ASource, ADestination, TbAsignatura);
  end;
  procedure AddFDCodParaleloId;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodParaleloId';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDNomParaleloId;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'NomParaleloId';
      DataType := ftString;
      Size := 5;
    end;
  end;
  procedure CargarParaleloId(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodParaleloId;
    AddFDNomParaleloId;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbParaleloId);
  end;
  procedure AddFDCodMateProhibicionTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodMateProhibicionTipo';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDNomMateProhibicionTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'NomMateProhibicionTipo';
      DataType := ftString;
      Size := 10;
    end;
  end;
  procedure AddFDColMateProhibicionTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'ColMateProhibicionTipo';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDValMateProhibicionTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'ValMateProhibicionTipo';
      DataType := ftFloat;
    end;
  end;
  procedure CargarMateriaProhibicionTipo(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodMateProhibicionTipo;
    AddFDNomMateProhibicionTipo;
    AddFDColMateProhibicionTipo;
    AddFDValMateProhibicionTipo;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbMateriaProhibicionTipo);
  end;
  procedure CargarHorarioLaborable(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodDia;
    AddFDCodHora;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbPeriodo);
  end;
  procedure AddFDSesion;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'Sesion';
      DataType := ftInteger;
    end;
  end;
  procedure CargarHorarioDetalle(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodHorario;
    AddFDCodNivel;
    AddFDCodEspecializacion;
    AddFDCodParaleloId;
    AddFDCodDia;
    AddFDCodHora;
    AddFDCodMateria;
    AddFDSesion;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbHorarioDetalle);
  end;
  procedure CargarParalelo(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodNivel;
    AddFDCodEspecializacion;
    AddFDCodParaleloId;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbParalelo);
  end;
  procedure AddFDCodProfesor;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodProfesor';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDCedProfesor;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CedProfesor';
      DataType := ftString;
      Size := 11;
    end;
  end;
  procedure AddFDApeProfesor;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'ApeProfesor';
      DataType := ftString;
      Size := 15;
    end;
  end;
  procedure AddFDNomProfesor;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'NomProfesor';
      DataType := ftString;
      Size := 15;
    end;
  end;
  procedure CargarProfesor(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodProfesor;
    AddFDCedProfesor;
    AddFDApeProfesor;
    AddFDNomProfesor;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbProfesor);
  end;
  procedure CargarMateriaProhibicion(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodMateria;
    AddFDCodDia;
    AddFDCodHora;
    AddFDCodMateProhibicionTipo;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbMateriaProhibicion);
  end;
  procedure CargarCargaAcademica(ASource, ADestination: TStream);
  var
    TbMemTableCodMateria, TbMemTableCodNivel, TbMemTableCodEspecializacion,
    TbMemTableCodParaleloId, TbMemTableCodProfesor: TIntegerField;
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodMateria;
    AddFDCodNivel;
    AddFDCodEspecializacion;
    AddFDCodParaleloId;
    AddFDCodProfesor;
    TbMemTable.Open;
    TbMemTableCodMateria := TIntegerField(TbMemTable.FindField('CodMateria'));
    TbMemTableCodNivel := TIntegerField(TbMemTable.FindField('CodNivel'));
    TbMemTableCodEspecializacion := TIntegerField(TbMemTable.FindField('CodEspecializacion'));
    TbMemTableCodParaleloId := TIntegerField(TbMemTable.FindField('CodParaleloId'));
    TbMemTableCodProfesor := TIntegerField(TbMemTable.FindField('CodProfesor'));
    with SourceBaseDataModule do
    try
      LoadDataSetFromStream(TbMemTable, ASource);
      TbDistributivo.EmptyTable;
      TbAsignatura.IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion';
      while not TbMemTable.Eof do
      begin
        TbAsignatura.Locate('CodMateria;CodNivel;CodEspecializacion',
                            VarArrayOf([TbMemTable.FindField('CodMateria'),
                                        TbMemTable.FindField('CodNivel'),
                                        TbMemTable.FindField('CodEspecializacion')]), []);
        TbDistributivo.Append;
        TbDistributivoCodMateria.Value := TbMemTableCodMateria.Value;
        TbDistributivoCodNivel.Value := TbMemTableCodNivel.Value;
        TbDistributivoCodEspecializacion.Value := TbMemTableCodEspecializacion.Value;
        TbDistributivoCodParaleloId.Value := TbMemTableCodParaleloId.Value;
        TbDistributivoCodProfesor.Value := TbMemTableCodProfesor.Value;
        TbDistributivoCodAulaTipo.Value := TbAsignaturaCodAulaTipo.Value;
        TbDistributivoComposicion.Value := TbAsignaturaComposicion.Value;
        TbDistributivo.Post;
        TbMemTable.Next;
      end;
      //TbDistributivo.LoadFromDataSet(TbMemTable, []);
    finally
      TbMemTable.Close;
    end;
    //LoadSource(ASource, ADestination, SourceBaseDataModule.TbCargaAcademica);
  end;
  procedure AddFDCodProfProhibicionTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'CodProfProhibicionTipo';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDNomProfProhibicionTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'NomProfProhibicionTipo';
      DataType := ftString;
      Size := 10;
    end;
  end;
  procedure AddFDColProfProhibicionTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'ColProfProhibicionTipo';
      DataType := ftInteger;
    end;
  end;
  procedure AddFDValProfProhibicionTipo;
  begin
    with TbMemTable.FieldDefs.AddFieldDef do
    begin
      Name := 'ValProfProhibicionTipo';
      DataType := ftFloat;
    end;
  end;
  procedure CargarProfesorProhibicionTipo(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodProfProhibicionTipo;
    AddFDNomProfProhibicionTipo;
    AddFDColProfProhibicionTipo;
    AddFDValProfProhibicionTipo;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbProfesorProhibicionTipo);
  end;
  procedure CargarProfesorProhibicion(ASource, ADestination: TStream);
  begin
    TbMemTable.FieldDefs.Clear;
    AddFDCodProfesor;
    AddFDCodDia;
    AddFDCodHora;
    AddFDCodProfProhibicionTipo;
    LoadSource(ASource, ADestination, SourceBaseDataModule.TbProfesorProhibicion);
  end;
  procedure ConvertConfig(ASource, ADestination: TStream);
  var
    c, i: Integer;
    n: Byte;
    Name: TFileName;
    VSize: Integer;
    VSizeW: Longint;
  begin
    with ASource do
    begin
      Read(c, SizeOf(c));
      if c <> 0 then
      begin
        for i := 1 to c do
        begin
          ASource.Read(n, SizeOf(n));
          SetLength(Name, n);
          ASource.Read(Name[1], n);
          ASource.Read(VSize, SizeOf(VSize));
          if UpperCase(Name) = 'CONFIG.INI' then
          begin
            VSizeW := VSize;
            ADestination.Write(VSizeW, SizeOf(VSizeW));
            ADestination.CopyFrom(ASource, VSizeW);
          end
          else
            ASource.Seek(VSize, soFromCurrent);
        end;
      end;
    end;
  end;
  procedure ConvertUnComp(ASource, ADestination: TStream);
  var
    i, l: Integer;
    List: TStrings;
    aw: PWordArray;
    s: string;
  begin
    ASource.Read(l, SizeOf(l));
    List := TStringList.Create;
    TbMemTable := TkbmMemTable.Create(nil);
    SourceBaseDataModule.CheckRelations := False;
    with List do
    try
      GetMem(aw, SizeOf(aw[0]) * l);
      try
        ASource.Read(aw[0], SizeOf(aw[0]) * l);
        for i := 0 to l - 1 do
        begin
          SetLength(s, aw[i]);
          ASource.Read(s[1], aw[i]);
          Add(s);
        end;
        for i := 0 to l - 1 do
        begin
          s := List.Strings[i];
          if s = 'AulaTipo' then
            CargarAulaTipo(ASource, ADestination)
          else if s = 'Especializacion' then
            CargarEspecializacion(ASource, ADestination)
          else if s = 'Nivel' then
            CargarNivel(ASource, ADestination)
          else if s = 'Materia' then
            CargarMateria(ASource, ADestination)
          else if s = 'Dia' then
            CargarDia(ASource, ADestination)
          else if s = 'Curso' then
            CargarCurso(ASource, ADestination)
          else if s = 'Hora' then
            CargarHora(ASource, ADestination)
          else if s = 'Horario' then
            CargarHorario(ASource, ADestination)
          else if s = 'Asignatura' then
            CargarAsignatura(ASource, ADestination)
          else if s = 'ParaleloId' then
            CargarParaleloId(ASource, ADestination)
          else if s = 'MateriaProhibicionTipo' then
            CargarMateriaProhibicionTipo(ASource, ADestination)
          else if s = 'HorarioLaborable' then
            CargarHorarioLaborable(ASource, ADestination)
          else if s = 'Paralelo' then
            CargarParalelo(ASource, ADestination)
          else if s = 'Profesor' then
            CargarProfesor(ASource, ADestination)
          else if s = 'MateriaProhibicion' then
            CargarMateriaProhibicion(ASource, ADestination)
          else if s = 'CargaAcademica' then
            CargarCargaAcademica(ASource, ADestination)
          else if s = 'HorarioDetalle' then
            CargarHorarioDetalle(ASource, ADestination)
          else if s = 'ProfesorProhibicionTipo' then
            CargarProfesorProhibicionTipo(ASource, ADestination)
          else if s = 'ProfesorProhibicion' then
            CargarProfesorProhibicion(ASource, ADestination)
          else raise EConvertError.CreateFmt('Tabla no encontrada %s', [s]);
        end;
        SourceBaseDataModule.SaveToBinaryStream(ADestination,
          [mtfSaveData,
          mtfSaveNonVisible,
            mtfSaveBlobs,
            mtfSaveFiltered,
            mtfSaveIgnoreRange,
            mtfSaveIgnoreMasterDetail,
            mtfSaveDeltas]);
        // Ahora, pasar el archivo Config.ini
        ConvertConfig(ASource, ADestination);
      finally
        FreeMem(aw);
      end;
    finally
      SourceBaseDataModule.CheckRelations := True;
      TbMemTable.Free;
      Free;
    end;
  end;

  procedure ConvertComp(ASource, ADestination: TStream);
  const
    BufferSize = 65536;
  var
    Count: Integer;
    Buffer: array[0..BufferSize - 1] of Byte;
    MemoryStream, MemoryStream2: TStream;
  begin
    MemoryStream := TMemoryStream.Create;
    try
      with TBZDecompressionStream.Create(ASource) do
      try
        while True do
        begin
          Count := Read(Buffer, BufferSize);
          if Count <> 0 then MemoryStream.WriteBuffer(Buffer, Count) else Break;
        end;
      finally
        Free;
      end;
      MemoryStream.Position := 0;
      MemoryStream2 := TMemoryStream.Create;
      try
        ConvertUncomp(MemoryStream, MemoryStream2);
        with TBZCompressionStream.Create(bs9, ADestination) do
        try
          CopyFrom(MemoryStream2, 0);
        finally
          Free;
        end;
      finally
        MemoryStream2.Free;
      end;
    finally
      MemoryStream.Free;
    end;
  end;
begin
  ASource.Read(PackerFileHeader, SizeOf(PackerFileHeader));
  if PackerFileHeader.GenHeader <> 'DBP' + ^Z then
    raise EConvertError.Create(SNotDBPackerFile);
  if PackerFileHeader.VersionNumber <> pfhPackerVersionNumber then
    raise EConvertError.CreateFmt(SInvalidDBPackerVersion,
      [PackerFileHeader.VersionNumber, pfhPackerVersionNumber]);
  HPCFileHeader.GenHeader := 'HPC' + ^Z;
  HPCFileHeader.VersionNumber := pfhHPCVersionNumber;
  ADestination.Write(HPCFileHeader, SizeOf(HPCFileHeader));
  if poCompress in PackerFileHeader.Options then
  begin
    ConvertComp(ASource, ADestination);
  end
  else
  begin
    ConvertUncomp(ASource, ADestination);
  end;
end;

procedure TConvertForm.ConvertDBP120_HPC121(const ASourceFileName, ADestinationFileName: string);
var
  ASource, ADestination: TStream;
begin
  ASource := TFileStream.Create(ASourceFileName, fmOpenRead + fmShareDenyNone);
  try
    ADestination := TFileStream.Create(ADestinationFileName, fmCreate);
    try
      ConvertDBP120_HPC121(ASource, ADestination);
    finally
      ADestination.Free;
    end;
  finally
    ASource.Free;
  end;
end;

procedure TConvertForm.btnConvertirClick(Sender: TObject);
begin
  ConvertDBP120_HPC121(feSource.FileName, feDestination.FileName);
end;

procedure TConvertForm.FormCreate(Sender: TObject);
var
  i: Integer;
  DataSet: TDataSet;
begin
  with SourceBaseDataModule do
  begin
    for i := 0 to ComponentCount - 1 do
    begin
      if Components[i] is TDataSet then
      begin
        DataSet := TDataSet(Components[i]);
        cbxDataSet.Items.Add(NameDataSet[DataSet]);
      end;
    end;
  end;
end;

procedure TConvertForm.cbxDataSetChange(Sender: TObject);
begin
  DBGrid1.DataSource := TDataSource(SourceBaseDataModule.FindComponent('ds' + cbxDataSet.Text));
end;

end.
