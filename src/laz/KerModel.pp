{ -*- mode: Delphi -*- }
unit KerModel;
{$I ttg.inc}
{.$mode objfpc}{.$H+}
{.$DEFINE USE_SQL}
interface

uses
  {$IFDEF UNIX}CThreads, CMem, {$ENDIF}Classes, DB, Dialogs, Forms, UIndivid;

var
  SortInteger: procedure(var List1: array of Integer;
    var List2: array of Integer; min, max: Integer);
  lSort: procedure(var List1: array of Integer; min, max: Integer);

type
  TDynamicBooleanArray = array of Boolean;
  TDynamicBooleanArrayArray = array of TDynamicBooleanArray;
  TDynamicIntegerArray = array of Integer;
  TDynamicIntegerArrayArray = array of TDynamicIntegerArray;
  TDynamicIntegerArrayArrayArray = array of TDynamicIntegerArrayArray;
  TDynamicDoubleArray = array of Double;
  TDynamicDoubleArrayArray = array of TDynamicDoubleArray;
  TDynamicStringArray = array of string;
  PIntegerArray = ^TIntegerArray;
  TIntegerArray = array [0 .. 16383] of Integer;
  PIntegerArrayArray = ^TIntegerArrayArray;
  TIntegerArrayArray = array [0 .. 0] of PIntegerArray;
  PDoubleArray = ^TDoubleArray;
  TDoubleArray = array [0 .. 0] of Double;
  PBooleanArray = ^TBooleanArray;
  TBooleanArray = array [0 .. 16383] of Boolean;
  {
    Clase TTimeTableModel
    Descripcion:
    Implementa la carga de la informacion desde la base de datos a la memoria
    RAM.
    Miembros privados:
    Todos los arreglos dinamicos que contienen la informacion, los campos que
    contienen los pesos de la funcion objetivo y las funciones de uso interno.
    Miembros protegidos:
    Arreglo dinamico que contiene el molde de un horario, que facilita la
    construccion de soluciones.
    Miembros publicos:
    El constructor, la funcion que permite configurar los pesos y los pesos
    de cada restriccion.
  }

  TTimeTable = class;
  TTimeTableArray = array of TTimeTable;

  { TTimeTableModel }

  TTimeTableModel = class(TObject)
  private
    FCruceProfesorValor, FCruceMateriaValor, FCruceAulaTipoValor,
      FHoraHuecaDesubicadaValor, FSesionCortadaValor,
      FProfesorFraccionamientoValor, FMateriaNoDispersaValor: Double;
    FPeriodoADia, FPeriodoAHora, FDiaAMaxPeriodo, FSesionADistributivo,
      FSesionAMateria, FSesionAAulaTipo, FAulaTipoACantidad,
      FMateriaProhibicionAMateria, FMateriaProhibicionAPeriodo,
      FMateriaProhibicionAMateriaProhibicionTipo,
      FProfesorProhibicionAProfesor, FProfesorProhibicionAPeriodo,
      FProfesorProhibicionAProfesorProhibicionTipo, FDistributivoAAulaTipo,
      FParaleloACurso, FParaleloANivel, FParaleloAParaleloId,
      FParaleloAEspecializacion, FParaleloASesionCant: TDynamicIntegerArray;
    FSesionADuracion: array [-1 .. 16382] of Integer;
    FPSesionADuracion: PIntegerArray;
    FDiaHoraAPeriodo, FNivelEspecializacionACurso, FCursoParaleloIdAParalelo,
      FParaleloMateriaAProfesor, FParaleloMateriaADistributivo, FParaleloMateriaCant,
      FTimeTableDetailPattern, FDistributivoASesiones: TDynamicIntegerArrayArray;
    FProfesorPeriodoAProfesorProhibicionTipo,
      FMateriaPeriodoAMateriaProhibicionTipo: TDynamicIntegerArrayArray;
    FMateriaProhibicionTipoAValor, FProfesorProhibicionTipoAValor: TDynamicDoubleArray;
    FMateriaProhibicionAValor, FProfesorProhibicionAValor: TDynamicDoubleArray;
    FMateriaCant, FMateriaProhibicionTipoCant, FProfesorProhibicionTipoCant,
      FParaleloCant, FDiaCant, FHoraCant, FPeriodoCant, FProfesorCant, FCursoCant,
      FNivelCant, FEspecializacionCant, FAulaTipoCant, FDistributivoCant,
      FMaxProfesorProhibicionTipo: Integer;
    FMaxProfesorProhibicionTipoValor: Double;
    FParaleloIdACodParaleloId, FMateriaACodMateria, FDiaACodDia, FHoraACodHora,
      FNivelACodNivel,
      FEspecializacionACodEspecializacion: TDynamicIntegerArray;
    FCodNivelANivel, FCodEspecializacionAEspecializacion,
      FCodParaleloIdAParaleloId, FCodDiaADia,
      FCodHoraAHora: TDynamicIntegerArray;
    FMinCodNivel, FMinCodEspecializacion, FMinCodParaleloId, FMinCodDia,
      FMinCodHora: Integer;
    FSesionCantidadDoble: Integer;
    function GetDiaAMaxPeriodo(Dia: Integer): Integer;
  protected
    property TimeTableDetailPattern: TDynamicIntegerArrayArray read FTimeTableDetailPattern;
    class function GetElitistCount: Integer;
  public
    procedure Configure(ACruceProfesorValor, ACruceMateriaValor,
      ACruceAulaTipoValor, AProfesorFraccionamientoValor,
      AHoraHuecaDesubicadaValor, ASesionCortadaValor, AMateriaNoDispersaValor: Double);
    constructor CreateFromDataModule(ACruceProfesorValor, ACruceMateriaValor,
      ACruceAulaTipoValor, AProfesorFraccionamientoValor,
      AHoraHuecaDesubicadaValor, ASesionCortadaValor, AMateriaNoDispersaValor: Double);
    destructor Destroy; override;
    procedure ReportParameters(AReport: TStrings);
    function NewIndividual: TObject;
    property PeriodoCant: Integer read FPeriodoCant;
    property ParaleloCant: Integer read FParaleloCant;
    property CruceProfesorValor: Double read FCruceProfesorValor;
    property CruceMateriaValor: Double read FCruceMateriaValor;
    property ProfesorFraccionamientoValor: Double read FProfesorFraccionamientoValor;
    property CruceAulaTipoValor: Double read FCruceAulaTipoValor;
    property HoraHuecaDesubicadaValor: Double read FHoraHuecaDesubicadaValor;
    property SesionCortadaValor: Double read FSesionCortadaValor;
    property MateriaNoDispersaValor: Double read FMateriaNoDispersaValor;
    property SesionCantidadDoble: Integer read FSesionCantidadDoble;
    property SesionADuracion: PIntegerArray read FPSesionADuracion;
    property ParaleloASesionCant: TDynamicIntegerArray read FParaleloASesionCant;
    property ElitistCount: Integer read GetElitistCount;
  end;

  // type
  // TCountFunc = procedure(Count, Cant: Integer) of object;
  {
    Clase TTimeTable
    Descripcion:
    Implementa una solucion del problema.
    Miembros privados:
    Todos los arreglos dinamicos que contienen la informacion consistentes en
    el horario, las claves aleatorias y datos temporales que aceleran la
    evaluacion de la funcion objetivo, los campos que contienen los valores
    de cada parte de la funcion objetivo y las funciones de uso interno.
    Miembros protegidos:
    Propiedad que forza a que se reevalue toda la funcion objetivo.
    Miembros publicos:
    propiedades que devuelven el valor de cada componente de la funcion
    objetivo, el valor de la funcion objetivo, el constructor, funciones que
    permiten guardar el horario en una base de datos, metodos que consisten
    en los operadores geneticos, como son cruce, mutacion, etc., TimeTableModel
    al que pertenece esta solucion.
  }

  { Manual Tabling:
    Here we have information that can be returned recalculating Values of the
    TTimeTable object, but that are preserved here in order to optimize
    computations.
  }
  (*

    TODO:
    2011-03-13:
    - Change implementation of MateriaNoDispersa for a more compositional formula
    - Remove FParaleloMateriaDia{Min,Max}Hora
    - IncCant and DecCant must be methods -DONE


  *)
  { TTimeTableTablingInfo }
  TTimeTableTablingInfo = record
    FProfesorPeriodoCant: TDynamicIntegerArrayArray;
    FMateriaPeriodoCant: TDynamicIntegerArrayArray;
    FAulaTipoPeriodoCant: TDynamicIntegerArrayArray;
    FParaleloDiaMateriaCant: TDynamicIntegerArrayArrayArray;
    FParaleloDiaMateriaAcum: TDynamicIntegerArrayArrayArray;
    FDiaProfesorFraccionamiento: TDynamicIntegerArrayArray;
    FMateriaProhibicionTipoAMateriaCant: TDynamicIntegerArray;
    FProfesorProhibicionTipoAProfesorCant: TDynamicIntegerArray;
    FCruceProfesor: Integer;
    FCruceMateria: Integer;
    FCruceAulaTipo: Integer;
    FProfesorFraccionamiento: Integer;
    FHoraHuecaDesubicada: Integer;
    FMateriaNoDispersa: Integer;
    FSesionCortada: Integer;
    FValue: Double;
  end;

  { TTimeTable }

  TTimeTable = class(TInterfacedObject, IIndividual)
  private
    FImplementor: TObject;
    FModel: TTimeTableModel;
    FParaleloPeriodoASesion: TDynamicIntegerArrayArray;
    TablingInfo: TTimeTableTablingInfo;
    { Required to synchronize threads: }
    procedure CheckIntegrity;
    procedure DeltaValues(Delta, AParalelo, Periodo1, Periodo2: Integer;
      var ActualizarDiaProfesor: TDynamicBooleanArrayArray);
    function DeltaSesionCortada(Paralelo, Periodo1, Periodo2: Integer): Integer;
    function GetCruceMateriaValor: Double;
    function GetMateriaNoDispersaValor: Double;
    function GetHoraHuecaDesubicadaValor: Double;
    function GetCruceProfesorValor: Double;
    function GetMateriaProhibicionValor: Double;
    function GetProfesorProhibicionValor: Double;
    function GetProfesorFraccionamientoValor: Double;
    function GetSesionCortadaValor: Double;
    function GetCruceAulaTipoValor: Double;
    function GetValue: Double;
    procedure InternalMutate;
    procedure Reset;
    procedure SetImplementor(const AValue: TObject);
    procedure Swap(AParalelo, APeriodo1, APeriodo2: Integer);
    procedure UpdateProfesorFraccionamiento(
      ActualizarDiaProfesor: TDynamicBooleanArrayArray);
    function GetDiaProfesorFraccionamiento(Dia, Profesor: Integer): Integer;
    function GetElitistValues(Index: Integer): Double;
  protected
  public
    procedure Update;
    function GetImplementor: TObject;
    property Implementor: TObject read FImplementor write SetImplementor;
    function DownHill(AParalelo: Integer; ExitOnFirstDown: Boolean;
                      Threshold: Double): Double; overload;
    function DownHill(ExitOnFirstDown, Forced: Boolean;
                      Threshold: Double): Double; overload;
    function DownHill: Double; overload;
    function DownHillForced: Double;
    procedure Normalize(AParalelo: Integer; var APeriodo: Integer);
    function InternalSwap(AParalelo, APeriodo1, APeriodo2: Integer): Double;
    procedure SaveToFile(const AFileName: string);
    procedure SaveToDataModule(CodHorario: Integer;
      MomentoInicial, MomentoFinal: TDateTime; Informe: TStrings);
    procedure LoadFromDataModule(CodHorario: Integer);
    procedure SaveToStream(Stream: TStream);
    procedure LoadFromStream(Stream: TStream);
    constructor Create(ATimeTableModel: TTimeTableModel);
    destructor Destroy; override;
    procedure MakeRandom;
    procedure Mutate; overload;
    procedure Mutate(Order: Integer); overload;
    procedure MutateDia;
    procedure ReportValues(AReport: TStrings);
    procedure Assign(ATimeTable: TTimeTable);
    property Value: Double read TablingInfo.FValue;
    property HoraHuecaDesubicada: Integer read TablingInfo.FHoraHuecaDesubicada;
    property MateriaProhibicionTipoAMateriaCant: TDynamicIntegerArray
      read TablingInfo.FMateriaProhibicionTipoAMateriaCant;
    property ProfesorProhibicionTipoAProfesorCant: TDynamicIntegerArray
      read TablingInfo.FProfesorProhibicionTipoAProfesorCant;
    property MateriaNoDispersa: Integer read TablingInfo.FMateriaNoDispersa;
    property SesionCortada: Integer read TablingInfo.FSesionCortada;
    property ElitistValues[Index: Integer]: Double read GetElitistValues;
    property CruceProfesor: Integer read TablingInfo.FCruceProfesor;
    property CruceMateria: Integer read TablingInfo.FCruceMateria;
    property CruceAulaTipo: Integer read TablingInfo.FCruceAulaTipo;
    property CruceProfesorValor: Double read GetCruceProfesorValor;
    property CruceMateriaValor: Double read GetCruceMateriaValor;
    property ProfesorFraccionamientoValor: Double read GetProfesorFraccionamientoValor;
    property CruceAulaTipoValor: Double read GetCruceAulaTipoValor;
    property HoraHuecaDesubicadaValor: Double read GetHoraHuecaDesubicadaValor;
    property SesionCortadaValor: Double read GetSesionCortadaValor;
    property MateriaNoDispersaValor: Double read GetMateriaNoDispersaValor;
    property MateriaProhibicionValor: Double read GetMateriaProhibicionValor;
    property ProfesorProhibicionValor: Double read GetProfesorProhibicionValor;
    property ParaleloPeriodoASesion: TDynamicIntegerArrayArray
      read FParaleloPeriodoASesion write FParaleloPeriodoASesion;
    property Model: TTimeTableModel read FModel;
    property ProfesorFraccionamiento: Integer read TablingInfo.FProfesorFraccionamiento;
  end;

// Procedimiento que aplica el operador de cruzamiento sobre dos TTimeTable
procedure CrossIndividuals(var TimeTable1, TimeTable2: TTimeTable);

implementation

uses
  SysUtils, ZSysUtils, ZConnection, MTProcs, SortAlgs, DSource, HorColCm;

constructor TTimeTableModel.CreateFromDataModule(ACruceProfesorValor,
  ACruceMateriaValor, ACruceAulaTipoValor, AProfesorFraccionamientoValor,
  AHoraHuecaDesubicadaValor, ASesionCortadaValor, AMateriaNoDispersaValor: Double);
var
  iMax: Integer;
  FMinCodProfesor, FMinCodMateria, FMinCodAulaTipo, FMinCodProfProhibicionTipo,
    FMinCodMateProhibicionTipo: Integer;
  FDistributivoAMateria, FCodMateriaAMateria, FCodProfesorAProfesor,
    FCodAulaTipoAAulaTipo, FCodProfProhibicionTipoAProfesorProhibicionTipo,
    FCodMateProhibicionTipoAMateriaProhibicionTipo, FParaleloADuracion,
    FDistributivoAProfesor, FDistributivoAParalelo: TDynamicIntegerArray;
  FProfesorACodProfesor, FProfesorProhibicionTipoACodProfProhibicionTipo,
    FAulaTipoACodAulaTipo, FMateriaProhibicionTipoACodMateProhibicionTipo: TDynamicIntegerArray;
  procedure Cargar(ATable: TDataSet; ALstName: string; out FMinCodLst: Integer;
    out FCodLstALst: TDynamicIntegerArray;
    out FLstACodLst: TDynamicIntegerArray);
  var
    VField: TField;
    I, v: Integer;
  begin
    with ATable do
    begin
      First;
      VField := FindField(ALstName);
      FMinCodLst := VField.AsInteger;
      iMax := VField.AsInteger;
      SetLength(FLstACodLst, RecordCount);
      for I := 0 to RecordCount - 1 do
      begin
        v := VField.AsInteger;
        if iMax < v then
          iMax := v;
        if FMinCodLst > v then
          FMinCodLst := v;
        FLstACodLst[I] := v;
        Next;
      end;
      First;
      SetLength(FCodLstALst, iMax - FMinCodLst + 1);
      for I := 0 to RecordCount - 1 do
      begin
        FCodLstALst[VField.AsInteger - FMinCodLst] := I;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarCurso;
  var
    Curso, Nivel, Especializacion: Integer;
    VFieldNivel, VFieldEspecializacion: TField;
  begin
    with SourceDataModule.TbCurso do
    begin
      IndexFieldNames := 'CodNivel;CodEspecializacion';
      First;
      FCursoCant := RecordCount;
      SetLength(FNivelEspecializacionACurso, FNivelCant, FEspecializacionCant);
      for Nivel := 0 to FNivelCant - 1 do
        for Especializacion := 0 to FEspecializacionCant - 1 do
          FNivelEspecializacionACurso[Nivel, Especializacion] := -1;
      VFieldNivel := FindField('CodNivel');
      VFieldEspecializacion := FindField('CodEspecializacion');
      for Curso := 0 to FCursoCant - 1 do
      begin
        Nivel := FCodNivelANivel[VFieldNivel.AsInteger - FMinCodNivel];
        Especializacion := FCodEspecializacionAEspecializacion
          [VFieldEspecializacion.AsInteger - FMinCodEspecializacion];
        FNivelEspecializacionACurso[Nivel, Especializacion] := Curso;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarPeriodo;
  var
    Periodo, Dia, Hora: Integer;
    VFieldDia, VFieldHora: TField;
  begin
    with SourceDataModule.TbPeriodo do
    begin
      IndexFieldNames := 'CodDia;CodHora';
      First;
      FPeriodoCant := RecordCount;
      SetLength(FPeriodoADia, FPeriodoCant);
      SetLength(FDiaAMaxPeriodo, FDiaCant);
      SetLength(FPeriodoAHora, FPeriodoCant);
      SetLength(FDiaHoraAPeriodo, FDiaCant, FHoraCant);
      for Dia := 0 to FDiaCant - 1 do
        for Hora := 0 to FHoraCant - 1 do
          FDiaHoraAPeriodo[Dia, Hora] := -1;
      VFieldDia := FindField('CodDia');
      VFieldHora := FindField('CodHora');
      for Periodo := 0 to FPeriodoCant - 1 do
      begin
        Dia := FCodDiaADia[VFieldDia.AsInteger - FMinCodDia];
        Hora := FCodHoraAHora[VFieldHora.AsInteger - FMinCodHora];
        FPeriodoADia[Periodo] := Dia;
        FPeriodoAHora[Periodo] := Hora;
        FDiaHoraAPeriodo[Dia, Hora] := Periodo;
        Next;
      end;
      for Dia := 0 to FDiaCant - 1 do
      begin
        FDiaAMaxPeriodo[Dia] := GetDiaAMaxPeriodo(Dia);
      end;
      First;
    end;
  end;
  procedure CargarParalelo;
  var
    Paralelo, Curso, ParaleloId, Nivel, Especializacion: Integer;
    VFieldNivel, VFieldEspecializacion, VFieldParaleloId: TField;
  begin
    with SourceDataModule.TbParalelo do
    begin
      IndexFieldNames := 'CodNivel;CodEspecializacion;CodParaleloId';
      First;
      FParaleloCant := RecordCount;
      SetLength(FParaleloACurso, FParaleloCant);
      SetLength(FParaleloAParaleloId, FParaleloCant);
      SetLength(FParaleloANivel, FParaleloCant);
      SetLength(FParaleloAEspecializacion, FParaleloCant);
      SetLength(FCursoParaleloIdAParalelo, FCursoCant, Length
          (FParaleloIdACodParaleloId));
      VFieldNivel := FindField('CodNivel');
      VFieldEspecializacion := FindField('CodEspecializacion');
      VFieldParaleloId := FindField('CodParaleloId');
      for Paralelo := 0 to FParaleloCant - 1 do
      begin
        Nivel := FCodNivelANivel[VFieldNivel.AsInteger - FMinCodNivel];
        Especializacion := FCodEspecializacionAEspecializacion
          [VFieldEspecializacion.AsInteger - FMinCodEspecializacion];
        Curso := FNivelEspecializacionACurso[Nivel, Especializacion];
        ParaleloId := FCodParaleloIdAParaleloId[VFieldParaleloId.AsInteger -
          FMinCodParaleloId];
        FParaleloACurso[Paralelo] := Curso;
        FParaleloANivel[Paralelo] := Nivel;
        FParaleloAParaleloId[Paralelo] := ParaleloId;
        FParaleloAEspecializacion[Paralelo] := Especializacion;
        FCursoParaleloIdAParalelo[Curso, ParaleloId] := Paralelo;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarAulaTipo;
  var
    AulaTipo: Integer;
    VFieldCantidad: TField;
  begin
    with SourceDataModule.TbAulaTipo do
    begin
      IndexFieldNames := 'CodAulaTipo';
      First;
      SetLength(FAulaTipoACantidad, RecordCount);
      VFieldCantidad := FindField('Cantidad');
      for AulaTipo := 0 to RecordCount - 1 do
      begin
        FAulaTipoACantidad[AulaTipo] := VFieldCantidad.AsInteger;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarMateriaProhibicionTipo;
  var
    MateriaProhibicionTipo: Integer;
    VFieldValor: TField;
  begin
    with SourceDataModule.TbMateriaProhibicionTipo do
    begin
      IndexFieldNames := 'CodMateProhibicionTipo';
      First;
      VFieldValor := FindField('ValMateProhibicionTipo');
      SetLength(FMateriaProhibicionTipoAValor, RecordCount);
      for MateriaProhibicionTipo := 0 to RecordCount - 1 do
      begin
        FMateriaProhibicionTipoAValor[MateriaProhibicionTipo] := VFieldValor.AsFloat;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarProfesorProhibicionTipo;
  var
    ProfesorProhibicionTipo: Integer;
    VFieldValor: TField;
  begin
    with SourceDataModule.TbProfesorProhibicionTipo do
    begin
      IndexFieldNames := 'CodProfProhibicionTipo';
      First;
      VFieldValor := FindField('ValProfProhibicionTipo');
      SetLength(FProfesorProhibicionTipoAValor, RecordCount);
      FMaxProfesorProhibicionTipo := -1;
      FMaxProfesorProhibicionTipoValor := -1.7E308;
      for ProfesorProhibicionTipo := 0 to RecordCount - 1 do
      begin
        FProfesorProhibicionTipoAValor[ProfesorProhibicionTipo] := VFieldValor.AsFloat;
        if FMaxProfesorProhibicionTipoValor < FProfesorProhibicionTipoAValor[ProfesorProhibicionTipo]
          then
        begin
          FMaxProfesorProhibicionTipoValor := FProfesorProhibicionTipoAValor[ProfesorProhibicionTipo];
          FMaxProfesorProhibicionTipo := ProfesorProhibicionTipo;
        end;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarMateriaProhibicion;
  var
    Materia, MateriaProhibicion, Periodo, MateriaProhibicionTipo: Integer;
    VFieldMateria, VFieldDia, VFieldHora, VFieldMateriaProhibicionTipo: TField;
  begin
    with SourceDataModule.TbMateriaProhibicion do
    begin
      IndexFieldNames := 'CodMateria;CodDia;CodHora';
      First;
      SetLength(FMateriaProhibicionAMateria, RecordCount);
      SetLength(FMateriaProhibicionAPeriodo, RecordCount);
      SetLength(FMateriaProhibicionAMateriaProhibicionTipo, RecordCount);
      SetLength(FMateriaProhibicionAValor, RecordCount);
      SetLength(FMateriaPeriodoAMateriaProhibicionTipo, FMateriaCant,
        FPeriodoCant);
      for Materia := 0 to FMateriaCant - 1 do
        for Periodo := 0 to FPeriodoCant - 1 do
          FMateriaPeriodoAMateriaProhibicionTipo[Materia, Periodo] := -1;
      VFieldMateria := FindField('CodMateria');
      VFieldDia := FindField('CodDia');
      VFieldHora := FindField('CodHora');
      VFieldMateriaProhibicionTipo := FindField('CodMateProhibicionTipo');
      for MateriaProhibicion := 0 to RecordCount - 1 do
      begin
        Materia := FCodMateriaAMateria[VFieldMateria.AsInteger - FMinCodMateria];
        Periodo := FDiaHoraAPeriodo[FCodDiaADia[VFieldDia.AsInteger - FMinCodDia],
          FCodHoraAHora[VFieldHora.AsInteger - FMinCodHora]];
        MateriaProhibicionTipo := FCodMateProhibicionTipoAMateriaProhibicionTipo
          [VFieldMateriaProhibicionTipo.AsInteger - FMinCodMateProhibicionTipo];
        FMateriaProhibicionAMateria[MateriaProhibicion] := Materia;
        FMateriaProhibicionAPeriodo[MateriaProhibicion] := Periodo;
        FMateriaProhibicionAMateriaProhibicionTipo[Materia] := MateriaProhibicionTipo;
        FMateriaProhibicionAValor[MateriaProhibicion] := FMateriaProhibicionTipoAValor[MateriaProhibicionTipo];
        FMateriaPeriodoAMateriaProhibicionTipo[Materia, Periodo] := MateriaProhibicionTipo;
        Next;
      end;
      First;
    end;
  end;
  procedure CargarProfesorProhibicion;
  var
    ProfesorProhibicion, Profesor, Periodo, Dia, Hora,
      ProfesorProhibicionTipo: Integer;
    Valor: Double;
    VFieldProfesor, VFieldDia, VFieldHora,
      VFieldProfesorProhibicionTipo: TField;
  begin
    with SourceDataModule.TbProfesorProhibicion do
    begin
      IndexFieldNames := 'CodProfesor;CodDia;CodHora';
      First;
      SetLength(FProfesorProhibicionAProfesor, RecordCount);
      SetLength(FProfesorProhibicionAPeriodo, RecordCount);
      SetLength(FProfesorProhibicionAProfesorProhibicionTipo, RecordCount);
      SetLength(FProfesorProhibicionAValor, RecordCount);
      SetLength(FProfesorPeriodoAProfesorProhibicionTipo, FProfesorCant,
        FPeriodoCant);
      for Profesor := 0 to FProfesorCant - 1 do
        for Periodo := 0 to FPeriodoCant - 1 do
          FProfesorPeriodoAProfesorProhibicionTipo[Profesor, Periodo] := -1;
      VFieldProfesor := FindField('CodProfesor');
      VFieldHora := FindField('CodHora');
      VFieldDia := FindField('CodDia');
      VFieldProfesorProhibicionTipo := FindField('CodProfProhibicionTipo');
      for ProfesorProhibicion := 0 to RecordCount - 1 do
      begin
        Profesor := FCodProfesorAProfesor[VFieldProfesor.AsInteger - FMinCodProfesor];
        Dia := FCodDiaADia[VFieldDia.AsInteger - FMinCodDia];
        Hora := FCodHoraAHora[VFieldHora.AsInteger - FMinCodHora];
        Periodo := FDiaHoraAPeriodo[Dia, Hora];
        ProfesorProhibicionTipo := FCodProfProhibicionTipoAProfesorProhibicionTipo
          [VFieldProfesorProhibicionTipo.AsInteger -
          FMinCodProfProhibicionTipo];
        FProfesorProhibicionAProfesor[ProfesorProhibicion] := Profesor;
        FProfesorProhibicionAPeriodo[ProfesorProhibicion] := Periodo;
        FProfesorProhibicionAProfesorProhibicionTipo[ProfesorProhibicion] := ProfesorProhibicionTipo;
        Valor := FProfesorProhibicionTipoAValor[ProfesorProhibicionTipo];
        FProfesorProhibicionAValor[ProfesorProhibicion] := Valor;
        FProfesorPeriodoAProfesorProhibicionTipo[Profesor, Periodo] := ProfesorProhibicionTipo;
        Next;
      end;
      First;
      Filter := '';
      Filtered := False;
    end;
  end;
  procedure CargarDistributivo;
  var
    Materia, Nivel, Especializacion, ParaleloId, Sesion1, Distributivo,
      Paralelo, Profesor, Curso, Sesion2, Sesion, AulaTipo, VPos: Integer;
    VFieldMateria, VFieldNivel, VFieldParaleloId, VFieldProfesor,
      VFieldEspecializacion, VFieldAulaTipo, VFieldComposicion: TField;
    VSesionADuracion, VSesionADistributivo: array [0 .. 16383] of Integer;
    Composicion: string;
  begin
    with SourceDataModule.TbDistributivo do
    begin
      IndexFieldNames := 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId';
      First;
      VFieldMateria := FindField('CodMateria');
      VFieldNivel := FindField('CodNivel');
      VFieldEspecializacion := FindField('CodEspecializacion');
      VFieldParaleloId := FindField('CodParaleloId');
      VFieldProfesor := FindField('CodProfesor');
      VFieldAulaTipo := FindField('CodAulaTipo');
      VFieldComposicion := FindField('Composicion');
      FDistributivoCant := RecordCount;
      // SetLength(FDistributivoAAsignatura, RecordCount);
      SetLength(FDistributivoAParalelo, FDistributivoCant);
      SetLength(FDistributivoAProfesor, FDistributivoCant);
      SetLength(FDistributivoAAulaTipo, FDistributivoCant);
      SetLength(FDistributivoASesiones, FDistributivoCant);
      SetLength(FDistributivoAMateria, FDistributivoCant);
      SetLength(FParaleloMateriaAProfesor, FParaleloCant, FMateriaCant);
      SetLength(FParaleloMateriaCant, FParaleloCant, FMateriaCant);
      SetLength(FParaleloMateriaADistributivo, FParaleloCant, FMateriaCant);
      for Paralelo := 0 to FParaleloCant - 1 do
        for Materia := 0 to FMateriaCant - 1 do
        begin
          FParaleloMateriaCant[Paralelo, Materia] := 0;
          FParaleloMateriaADistributivo[Paralelo, Materia] := -1;
          FParaleloMateriaAProfesor[Paralelo, Materia] := -1;
        end;
      Sesion2 := 0;
      for Distributivo := 0 to RecordCount - 1 do
      begin
        Materia := FCodMateriaAMateria[VFieldMateria.AsInteger - FMinCodMateria];
        Nivel := FCodNivelANivel[VFieldNivel.AsInteger - FMinCodNivel];
        ParaleloId := FCodParaleloIdAParaleloId[VFieldParaleloId.AsInteger -
          FMinCodParaleloId];
        Especializacion := FCodEspecializacionAEspecializacion
          [VFieldEspecializacion.AsInteger - FMinCodEspecializacion];
        AulaTipo := FCodAulaTipoAAulaTipo[VFieldAulaTipo.AsInteger - FMinCodAulaTipo];
        Curso := FNivelEspecializacionACurso[Nivel, Especializacion];
        Paralelo := FCursoParaleloIdAParalelo[Curso, ParaleloId];
        Profesor := FCodProfesorAProfesor[VFieldProfesor.AsInteger - FMinCodProfesor];
        FDistributivoAParalelo[Distributivo] := Paralelo;
        FDistributivoAProfesor[Distributivo] := Profesor;
        FDistributivoAAulaTipo[Distributivo] := AulaTipo;
        FDistributivoAMateria[Distributivo] := Materia;
        FParaleloMateriaAProfesor[Paralelo, Materia] := Profesor;
        FParaleloMateriaADistributivo[Paralelo, Materia] := Distributivo;
        Composicion := VFieldComposicion.AsString;
        VPos := 1;
        Sesion1 := Sesion2;
        // t := 0;
        while VPos <= Length(Composicion) do
        begin
          VSesionADuracion[Sesion2] := StrToInt(ExtractString(Composicion, VPos, '.'));
          VSesionADistributivo[Sesion2] := Distributivo;
          Inc(FParaleloMateriaCant[Paralelo, Materia]);
          // Inc(t, VSesionADuracion[Sesion2]);
          Inc(Sesion2);
        end;
        SetLength(FDistributivoASesiones[Distributivo], Sesion2 - Sesion1);
        for Sesion := Sesion1 to Sesion2 - 1 do
        begin
          FDistributivoASesiones[Distributivo, Sesion - Sesion1] := Sesion;
        end;
        // FParaleloADuracion[Paralelo] := FParaleloADuracion[Paralelo] + t;
        Next;
      end;
      SetLength(FSesionADistributivo, Sesion2);
      SetLength(FSesionAMateria, Sesion2);
      SetLength(FSesionAAulaTipo, Sesion2);
      Move(VSesionADuracion[0], FSesionADuracion[0], Sesion2 * SizeOf(Integer));
      FSesionADuracion[-1] := 1;
      Move(VSesionADistributivo[0], FSesionADistributivo[0],
        Sesion2 * SizeOf(Integer));
      for Sesion := 0 to Sesion2 - 1 do
      begin
        Distributivo := FSesionADistributivo[Sesion];
        FSesionAMateria[Sesion] := FDistributivoAMateria[Distributivo];
        FSesionAAulaTipo[Sesion] := FDistributivoAAulaTipo[Distributivo];
      end;
    end;
  end;
  procedure CargarMoldeHorarioDetalle;
  var
    Periodo1, Paralelo, Distributivo, Periodo, Contador, Duracion, Cantidad: Integer;
  begin
    SetLength(FTimeTableDetailPattern, FParaleloCant, FPeriodoCant);
    SetLength(FParaleloASesionCant, FParaleloCant);
    SetLength(FParaleloADuracion, FParaleloCant);
    for Paralelo := 0 to FParaleloCant - 1 do
      for Periodo := 0 to FPeriodoCant - 1 do
        FTimeTableDetailPattern[Paralelo, Periodo] := -1;
    for Distributivo := FDistributivoCant - 1 downto 0 do
    begin
      Paralelo := FDistributivoAParalelo[Distributivo];
      for Contador := High(FDistributivoASesiones[Distributivo]) downto 0 do
      begin
        Duracion := FSesionADuracion[FDistributivoASesiones[Distributivo, Contador]];
        Periodo1 := FParaleloADuracion[Paralelo];
        for Periodo := Periodo1 + Duracion - 1 downto Periodo1 do
        begin
          if (Periodo < 0) or (Periodo >= FPeriodoCant) then
            raise Exception.CreateFmt(
              'Se desbordo Molde de ParaleloPeriodoASesion: ' +
                'Paralelo %d-%d Duracion %d', [FParaleloANivel[Paralelo],
              FParaleloAParaleloId[Paralelo], Periodo]);
          FTimeTableDetailPattern[Paralelo, FPeriodoCant - 1 - Periodo]
            := FDistributivoASesiones[Distributivo, Contador];
        end;
        Inc(FParaleloADuracion[Paralelo], Duracion);
      end;
    end;
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      Periodo := 0;
      while Periodo < FPeriodoCant do
      begin
        Periodo1 := FSesionADuracion[FTimeTableDetailPattern[Paralelo, Periodo]];
        Inc(Periodo, Periodo1);
        Inc(FParaleloASesionCant[Paralelo]);
      end;
    end;
    FSesionCantidadDoble := 0;
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      Cantidad := FParaleloASesionCant[Paralelo];
      Inc(FSesionCantidadDoble, (Cantidad * (Cantidad - 1)) div 2);
    end;
  end;
begin
  inherited Create;
  FPSesionADuracion := @FSesionADuracion[0];
  with SourceDataModule do
  begin
    Configure(ACruceProfesorValor, ACruceMateriaValor, ACruceAulaTipoValor,
      AProfesorFraccionamientoValor, AHoraHuecaDesubicadaValor,
      ASesionCortadaValor, AMateriaNoDispersaValor);
    Cargar(TbProfesor, 'CodProfesor', FMinCodProfesor, FCodProfesorAProfesor,
      FProfesorACodProfesor);
    FProfesorCant := Length(FProfesorACodProfesor);
    Cargar(TbNivel, 'CodNivel', FMinCodNivel, FCodNivelANivel, FNivelACodNivel);
    FNivelCant := Length(FNivelACodNivel);
    Cargar(TbEspecializacion, 'CodEspecializacion', FMinCodEspecializacion,
      FCodEspecializacionAEspecializacion, FEspecializacionACodEspecializacion);
    FEspecializacionCant := Length(FEspecializacionACodEspecializacion);
    CargarCurso;
    Cargar(TbParaleloId, 'CodParaleloId', FMinCodParaleloId,
      FCodParaleloIdAParaleloId, FParaleloIdACodParaleloId);
    Cargar(TbMateria, 'CodMateria', FMinCodMateria, FCodMateriaAMateria,
      FMateriaACodMateria);
    FMateriaCant := Length(FMateriaACodMateria);
    Cargar(TbDia, 'CodDia', FMinCodDia, FCodDiaADia, FDiaACodDia);
    FDiaCant := Length(FDiaACodDia);
    Cargar(TbHora, 'CodHora', FMinCodHora, FCodHoraAHora, FHoraACodHora);
    FHoraCant := Length(FHoraACodHora);
    Cargar(TbMateriaProhibicionTipo, 'CodMateProhibicionTipo',
      FMinCodMateProhibicionTipo,
      FCodMateProhibicionTipoAMateriaProhibicionTipo,
      FMateriaProhibicionTipoACodMateProhibicionTipo);
    FMateriaProhibicionTipoCant := Length(FMateriaProhibicionTipoACodMateProhibicionTipo);
    Cargar(TbProfesorProhibicionTipo, 'CodProfProhibicionTipo',
      FMinCodProfProhibicionTipo,
      FCodProfProhibicionTipoAProfesorProhibicionTipo,
      FProfesorProhibicionTipoACodProfProhibicionTipo);
    FProfesorProhibicionTipoCant := Length(FProfesorProhibicionTipoACodProfProhibicionTipo);
    Cargar(TbAulaTipo, 'CodAulaTipo', FMinCodAulaTipo, FCodAulaTipoAAulaTipo,
      FAulaTipoACodAulaTipo);
    FAulaTipoCant := Length(FAulaTipoACodAulaTipo);
    CargarPeriodo;
    CargarParalelo;
    CargarAulaTipo;
    CargarMateriaProhibicionTipo;
    CargarProfesorProhibicionTipo;
    CargarMateriaProhibicion;
    CargarProfesorProhibicion;
    CargarDistributivo;
    CargarMoldeHorarioDetalle;
  end;
end;

procedure TTimeTableModel.Configure(ACruceProfesorValor, ACruceMateriaValor,
  ACruceAulaTipoValor, AProfesorFraccionamientoValor, AHoraHuecaDesubicadaValor,
  ASesionCortadaValor, AMateriaNoDispersaValor: Double);
begin
  FCruceProfesorValor := ACruceProfesorValor;
  FCruceMateriaValor := ACruceMateriaValor;
  FProfesorFraccionamientoValor := AProfesorFraccionamientoValor;
  FCruceAulaTipoValor := ACruceAulaTipoValor;
  FHoraHuecaDesubicadaValor := AHoraHuecaDesubicadaValor;
  FSesionCortadaValor := ASesionCortadaValor;
  FMateriaNoDispersaValor := AMateriaNoDispersaValor;
end;

function TTimeTableModel.GetDiaAMaxPeriodo(Dia: Integer): Integer;
begin
  if Dia = FDiaCant - 1 then
    Result := FPeriodoCant - 1
  else
    Result := FDiaHoraAPeriodo[Dia + 1, 0] - 1;
end;

procedure TTimeTableModel.ReportParameters(AReport: TStrings);
begin
  AReport.Add(Format('Pesos:'#13#10 +
        '  Cruce de profesores          %8.2f'#13#10 +
        '  Cruce de materias            %8.2f'#13#10 +
        '  Cruce de aulas:              %8.2f'#13#10 +
        '  Fracc. h. profesores         %8.2f'#13#10 +
        '  Horas Huecas desubicadas:    %8.2f'#13#10 +
        '  Materias cortadas:           %8.2f'#13#10 +
        '  Materias juntas:             %8.2f', [
          CruceProfesorValor, CruceMateriaValor, CruceAulaTipoValor,
          ProfesorFraccionamientoValor, HoraHuecaDesubicadaValor,
          SesionCortadaValor, MateriaNoDispersaValor]));
end;

function TTimeTableModel.NewIndividual: TObject;
begin
  Result := TTimeTable.Create(Self);
end;

procedure CrossIndividualsParalelo(var TimeTable1, TimeTable2: TTimeTable;
    AParalelo: Integer);
  procedure RandomizeKey(ATimeTable: TTimeTable; var ARandomKey: TDynamicIntegerArray);
  var
    Periodo, Duracion, Counter, MaxPeriodo: Integer;
    PeriodoASesion: TDynamicIntegerArray;
    NumberList: array [0 .. 4095] of Integer;
  begin
    with ATimeTable.Model do
    begin
      // Check(AParalelo, 'AleatorizarClaveAntes');
      for Counter := 0 to FParaleloASesionCant[AParalelo] - 1 do
      NumberList[Counter] := Random($7FFFFFFF);
      lSort(NumberList, 0, FParaleloASesionCant[AParalelo] - 1);
      PeriodoASesion := ATimeTable.ParaleloPeriodoASesion[AParalelo];
      Periodo := 0;
      Counter := 0;
      while Periodo < FPeriodoCant do
      begin
        Duracion := FSesionADuracion[PeriodoASesion[Periodo]];
        MaxPeriodo := Periodo + Duracion;
        while Periodo < MaxPeriodo do
        begin
          ARandomKey[Periodo] := NumberList[Counter];
          Inc(Periodo);
        end;
        Inc(Counter);
      end;
    end;
  end;
var
  Sesion, Periodo, Duracion, Key1, Key2, MaxPeriodo: Integer;
  RandomKey1, RandomKey2: TDynamicIntegerArray;
begin
  with TimeTable1.Model do
  begin
    SetLength(RandomKey1, FPeriodoCant);
    SetLength(RandomKey2, FPeriodoCant);
    RandomizeKey(TimeTable1, RandomKey1);
    RandomizeKey(TimeTable2, RandomKey2);
    SortInteger(TimeTable1.ParaleloPeriodoASesion[AParalelo],
      RandomKey1, 0, FPeriodoCant - 1);
    SortInteger(TimeTable2.ParaleloPeriodoASesion[AParalelo],
      RandomKey2, 0, FPeriodoCant - 1);
    Periodo := 0;
    while Periodo < FPeriodoCant do
    begin
      Sesion := FTimeTableDetailPattern[AParalelo, Periodo];
      Duracion := FSesionADuracion[Sesion];
      if Random(2) = 0 then
      begin
        Key1 := RandomKey1[Periodo];
        Key2 := RandomKey2[Periodo];
        MaxPeriodo := Periodo + Duracion;
        while Periodo < MaxPeriodo do
        begin
          RandomKey1[Periodo] := Key2;
          RandomKey2[Periodo] := Key1;
          Inc(Periodo);
        end;
      end
      else
        Inc(Periodo, Duracion);
    end;
    SortInteger(RandomKey1, TimeTable1.ParaleloPeriodoASesion[AParalelo], 0,
      FPeriodoCant - 1);
    SortInteger(RandomKey2, TimeTable2.ParaleloPeriodoASesion[AParalelo], 0,
      FPeriodoCant - 1);
  end;
end;

procedure CrossIndividuals(var TimeTable1, TimeTable2: TTimeTable);
var
  Paralelo: Integer;
begin
  with TimeTable1.Model do
  begin
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      CrossIndividualsParalelo(TimeTable1, TimeTable2, Paralelo);
    end;
    TimeTable1.Update;
    TimeTable2.Update;
  end;
end;

constructor TTimeTable.Create(ATimeTableModel: TTimeTableModel);
begin
  inherited Create;
  FModel := ATimeTableModel;
  with Model do
  begin
    SetLength(FParaleloPeriodoASesion, FParaleloCant, FPeriodoCant);
    with TablingInfo do
    begin
      SetLength(FMateriaPeriodoCant, FMateriaCant, FPeriodoCant);
      SetLength(FProfesorPeriodoCant, FProfesorCant, FPeriodoCant);
      SetLength(FAulaTipoPeriodoCant, FAulaTipoCant, FPeriodoCant);
      SetLength(FParaleloDiaMateriaCant, FParaleloCant, FDiaCant, FMateriaCant);
      SetLength(FParaleloDiaMateriaAcum, FParaleloCant, FDiaCant, FMateriaCant);
      SetLength(FDiaProfesorFraccionamiento, FDiaCant, FProfesorCant);
      SetLength(FMateriaProhibicionTipoAMateriaCant, FMateriaProhibicionTipoCant);
      SetLength(FProfesorProhibicionTipoAProfesorCant, FProfesorProhibicionTipoCant);
    end;
  end;
end;

function TTimeTable.GetElitistValues(Index: Integer): Double;
begin
  case Index of
    0: Result := SesionCortada;
    1: Result := CruceProfesor;
    2: Result := CruceAulaTipo;
  end;
end;

procedure TTimeTable.MakeRandom;
var
  Paralelo, Periodo, Duracion, MaxPeriodo, RandomKey: Integer;
  PeriodoASesion: TDynamicIntegerArray;
  RandomKeys: TDynamicIntegerArray;
begin
  with Model do
  begin
    SetLength(RandomKeys, FPeriodoCant);
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      PeriodoASesion := ParaleloPeriodoASesion[Paralelo];
      for Periodo := 0 to FPeriodoCant - 1 do
        PeriodoASesion[Periodo] := FTimeTableDetailPattern[Paralelo, Periodo];
      Periodo := 0;
      while Periodo < FPeriodoCant do
      begin
        Duracion := FSesionADuracion[PeriodoASesion[Periodo]];
        RandomKey := Random($7FFFFFFF);
        MaxPeriodo := Periodo + Duracion;
        while Periodo < MaxPeriodo do
        begin
          RandomKeys[Periodo] := RandomKey;
          Inc(Periodo);
        end;
      end;
      SortInteger(RandomKeys, PeriodoASesion, 0, FPeriodoCant - 1);
    end;
  end;
  Update;
end;

procedure TTimeTable.Swap(AParalelo, APeriodo1, APeriodo2: Integer);
begin
  Normalize(AParalelo, APeriodo1);
  Normalize(AParalelo, APeriodo2);
  if APeriodo1 < APeriodo2 then
    InternalSwap(AParalelo, APeriodo1, APeriodo2)
  else if APeriodo2 < APeriodo1 then
    InternalSwap(AParalelo, APeriodo2, APeriodo1);
end;

procedure TTimeTable.DeltaValues(Delta, AParalelo, Periodo1, Periodo2: Integer;
  var ActualizarDiaProfesor: TDynamicBooleanArrayArray);
var
  MateriaProhibicionTipo, ProfesorProhibicionTipo, Periodo, Dia, DDia, Dia1,
    Dia2, Sesion, Profesor, AulaTipo, Duracion, Materia, Limit: Integer;
  PeriodoASesion: TDynamicIntegerArray;
  MateriaAProfesor: TDynamicIntegerArray;
begin
  with Model, TablingInfo do
  begin
    Inc(FSesionCortada, Delta * DeltaSesionCortada(AParalelo, Periodo1, Periodo2));
    PeriodoASesion := FParaleloPeriodoASesion[AParalelo];
    MateriaAProfesor := FParaleloMateriaAProfesor[AParalelo];
    if Delta > 0 then
      Limit := 0
    else
      Limit := 1;
    for Periodo := Periodo1 to Periodo2 do
    begin
      Sesion := PeriodoASesion[Periodo];
      if Sesion >= 0 then
      begin
        Materia := FSesionAMateria[Sesion];
        Profesor := MateriaAProfesor[Materia];
        AulaTipo := FSesionAAulaTipo[Sesion];
        Dia := FPeriodoADia[Periodo];
        ActualizarDiaProfesor[Dia, Profesor] := True;
        if FProfesorPeriodoCant[Profesor, Periodo] > Limit then
          Inc(FCruceProfesor, Delta);
        Inc(FProfesorPeriodoCant[Profesor, Periodo], Delta);
        Inc(FMateriaPeriodoCant[Materia, Periodo], Delta);
        if FAulaTipoPeriodoCant[AulaTipo, Periodo] >= FAulaTipoACantidad[AulaTipo] + Limit then
          Inc(FCruceAulaTipo, Delta);
        Inc(FAulaTipoPeriodoCant[AulaTipo, Periodo], Delta);
        MateriaProhibicionTipo := FMateriaPeriodoAMateriaProhibicionTipo[Materia, Periodo];
        if MateriaProhibicionTipo >= 0 then
          Inc(FMateriaProhibicionTipoAMateriaCant[MateriaProhibicionTipo], Delta);
        ProfesorProhibicionTipo := FProfesorPeriodoAProfesorProhibicionTipo[Profesor, Periodo];
        if ProfesorProhibicionTipo >= 0 then
          Inc(FProfesorProhibicionTipoAProfesorCant[ProfesorProhibicionTipo], Delta);
      end
      else if FHoraCant - 1 <> FPeriodoAHora[Periodo] then
        Inc(FHoraHuecaDesubicada, Delta);
    end;
    Periodo := Periodo1;
    while Periodo <= Periodo2 do
    begin
      Sesion := PeriodoASesion[Periodo];
      Duracion := FSesionADuracion[Sesion];
      if Sesion >= 0 then
      begin
        Materia := FSesionAMateria[Sesion];
        Dia1 := FPeriodoADia[Periodo];
        Dia2 := FPeriodoADia[Periodo + Duracion - 1];
        for Dia := Dia1 to Dia2 do
        begin
          if FParaleloDiaMateriaCant[AParalelo, Dia, Materia] > Limit then
            Inc(FCruceMateria, Delta);
          Inc(FParaleloDiaMateriaCant[AParalelo, Dia, Materia], Delta);
        end;
        DDia := FDiaCant div FParaleloMateriaCant[AParalelo, Materia];
        for Dia2 := Dia1 to Dia1 + DDia - 1 do
        begin
          Dia := Dia2 mod (FDiaCant + 1);
          if Dia <> FDiaCant then
          begin
            if FParaleloDiaMateriaAcum[AParalelo, Dia, Materia] > Limit then
              Inc(FMateriaNoDispersa, Delta);
            Inc(FParaleloDiaMateriaAcum[AParalelo, Dia, Materia], Delta);
          end;
        end;
      end;
      Inc(Periodo, Duracion);
    end;
  end;
end;

procedure TTimeTable.UpdateProfesorFraccionamiento(ActualizarDiaProfesor: TDynamicBooleanArrayArray);
var
  Dia, Profesor: Integer;
begin
  with Model, TablingInfo do
  begin
    for Dia := 0 to FDiaCant - 1 do
    begin
      for Profesor := 0 to FProfesorCant - 1 do
        if ActualizarDiaProfesor[Dia, Profesor] then
        begin
          Dec(FProfesorFraccionamiento, FDiaProfesorFraccionamiento[Dia, Profesor]);
          FDiaProfesorFraccionamiento[Dia, Profesor] :=
            GetDiaProfesorFraccionamiento(Dia, Profesor);
          Inc(FProfesorFraccionamiento, FDiaProfesorFraccionamiento[Dia, Profesor]);
        end;
    end;
  end;
end;

function TTimeTable.InternalSwap(AParalelo, APeriodo1, APeriodo2: Integer): Double;
var
  Duracion1, Duracion2, Sesion1, Sesion2: Integer;
  PeriodoASesion: TDynamicIntegerArray;
  ActualizarDiaProfesor: TDynamicBooleanArrayArray;
  procedure DoMovement;
  var
    Periodo: Integer;
  begin
    Move(PeriodoASesion[APeriodo1 + Duracion1], PeriodoASesion[APeriodo1 + Duracion2],
      (APeriodo2 - APeriodo1 - Duracion1) * SizeOf(Integer));
    for Periodo := APeriodo1 to APeriodo1 + Duracion2 - 1 do
      PeriodoASesion[Periodo] := Sesion2;
    for Periodo := APeriodo2 + Duracion2 - Duracion1 to APeriodo2 + Duracion2 - 1 do
      PeriodoASesion[Periodo] := Sesion1;
  end;
  // Values that requires total recalculation:
var
  Dia, Profesor, Periodo: Integer;
  {$IFDEF DEBUG}
  Value1, Value2: Double;
  CruceProfesor2: Integer;
  CruceMateria2: Integer;
  CruceAulaTipo2: Integer;
  ProfesorFraccionamiento2: Integer;
  HoraHuecaDesubicada2: Integer;
  MateriaProhibicionValor2: Double;
  MateriaNoDispersa2: Integer;
  ProfesorProhibicionValor2: Double;
  SesionCortada2: Integer;
  {$ENDIF}
begin
  with Model, TablingInfo do
  begin
    Result := FValue;
    {$IFDEF DEBUG}
    Update;
    Value1 := FValue;
    {$ENDIF}
    PeriodoASesion := ParaleloPeriodoASesion[AParalelo];
    Sesion1 := PeriodoASesion[APeriodo1];
    Sesion2 := PeriodoASesion[APeriodo2];
    Duracion1 := FSesionADuracion[Sesion1];
    Duracion2 := FSesionADuracion[Sesion2];
    SetLength(ActualizarDiaProfesor, FDiaCant, FProfesorCant);
    for Dia := 0 to FDiaCant - 1 do
      for Profesor := 0 to FProfesorCant - 1 do
        ActualizarDiaProfesor[Dia, Profesor] := False;
    if (Duracion1 = Duracion2) then
    begin
      DeltaValues(-1, AParalelo, APeriodo1, APeriodo1 + Duracion1 - 1,
        ActualizarDiaProfesor);
      DeltaValues(-1, AParalelo, APeriodo2, APeriodo2 + Duracion2 - 1,
        ActualizarDiaProfesor);
      for Periodo := APeriodo1 to APeriodo1 + Duracion2 - 1 do
        PeriodoASesion[Periodo] := Sesion2;
      for Periodo := APeriodo2 to APeriodo2 + Duracion2 - 1 do
        PeriodoASesion[Periodo] := Sesion1;
      DeltaValues(1, AParalelo, APeriodo1, APeriodo1 + Duracion1 - 1,
        ActualizarDiaProfesor);
      DeltaValues(1, AParalelo, APeriodo2, APeriodo2 + Duracion2 - 1,
        ActualizarDiaProfesor);
    end
    else
    begin
      DeltaValues(-1, AParalelo, APeriodo1, APeriodo2 + Duracion2 - 1,
        ActualizarDiaProfesor);
      DoMovement;
      DeltaValues(1, AParalelo, APeriodo1, APeriodo2 + Duracion2 - 1,
        ActualizarDiaProfesor);
    end;
    UpdateProfesorFraccionamiento(ActualizarDiaProfesor);
    FValue := GetValue;
    {$IFDEF DEBUG}
    CruceAulaTipo2 := FCruceAulaTipo;
    CruceProfesor2 := FCruceProfesor;
    CruceMateria2 := FCruceMateria;
    HoraHuecaDesubicada2 := FHoraHuecaDesubicada;
    MateriaNoDispersa2 := FMateriaNoDispersa;
    MateriaProhibicionValor2 := MateriaProhibicionValor;
    ProfesorFraccionamiento2 := FProfesorFraccionamiento;
    ProfesorProhibicionValor2 := ProfesorProhibicionValor;
    SesionCortada2 := FSesionCortada;
    Value2 := FValue;
    Update;
    if abs(FValue - Result - (Value2 - Value1)) > 0.000001 then
      raise Exception.CreateFmt(
      'Value1                   %f - %f'#13#10 +
      'Value2                   %f - %f'#13#10 +
      'CruceProfesor            %d - %d'#13#10 +
      'CruceMateria             %d - %d'#13#10 +
      'CruceAulaTipo            %d - %d'#13#10 +
      'HoraHuecaDesubicada      %d - %d'#13#10 +
      'MateriaNoDispersa        %d - %d'#13#10 +
      'MateriaProhibicionValor  %f - %f'#13#10 +
      'ProfesorFraccionamiento  %d - %d'#13#10 +
      'ProfesorProhibicionValor %f - %f'#13#10 +
      'SesionCortada            %d - %d',
      [
        Result, Value1,
        FValue, Value2,
        FCruceProfesor, CruceProfesor2,
        FCruceMateria, CruceMateria2,
        FCruceAulaTipo, CruceAulaTipo2,
        FHoraHuecaDesubicada, HoraHuecaDesubicada2,
        FMateriaNoDispersa, MateriaNoDispersa2,
        MateriaProhibicionValor, MateriaProhibicionValor2,
        FProfesorFraccionamiento, ProfesorFraccionamiento2,
        ProfesorProhibicionValor, ProfesorProhibicionValor2,
        FSesionCortada, SesionCortada2
        ]);
    {$ENDIF}
    Result := FValue - Result;
  end;
end;

{WARNING!!! Normalize is a Kludge, avoid its usage!!!}
procedure TTimeTable.Normalize(AParalelo: Integer; var APeriodo: Integer);
var
  Sesion: Integer;
  PeriodoASesion: TDynamicIntegerArray;
begin
  PeriodoASesion := FParaleloPeriodoASesion[AParalelo];
  Sesion := PeriodoASesion[APeriodo];
  if Sesion >= 0 then
    while (APeriodo > 0) and (Sesion = PeriodoASesion[APeriodo - 1]) do
      Dec(APeriodo);
end;

{Assembler version of Normalize}
(*
  procedure TTimeTable.Normalize(AParalelo: Integer; var APeriodo: Integer); assembler;
  asm
  push    ebx
  mov     eax, [eax + FParaleloPeriodoASesion]
  movsx   edx, AParalelo
  mov     eax, [eax + edx * 4]
  movsx   edx, word ptr [ecx]
  mov     bx, [eax + edx * 2]
  cmp     bx, 0
  jl      @end2
  @beg:
  cmp     edx, 0
  jle     @end
  cmp     bx, word ptr [eax + edx * 2 - 2]
  jne     @end
  Dec     edx
  jmp     @beg
  @end:
  mov     [ecx], dx
  @end2:
  pop     ebx
  end;
*)

procedure TTimeTable.ReportValues(AReport: TStrings);
begin
  with AReport, TablingInfo do
  begin
    Add('-----------------------------------------------------------------');
    Add('Detalle                           Cant.           Peso      Valor');
    Add('-----------------------------------------------------------------');
    Add(Format('Cruce de profesores:       %13.d %13.0f %10.0f',
        [FCruceProfesor, Model.CruceProfesorValor, CruceProfesorValor]));
    Add(Format('Cruce de materias:         %13.d %13.0f %10.0f',
        [FCruceMateria, Model.CruceMateriaValor, CruceMateriaValor]));
    Add(Format('Cruce de aulas:            %13.d %13.0f %10.0f',
        [FCruceAulaTipo, Model.CruceAulaTipoValor, CruceAulaTipoValor]));
    Add(Format('Fracc. h. profesores:      %13.d %13.0f %10.0f',
        [ProfesorFraccionamiento, Model.ProfesorFraccionamientoValor,
        ProfesorFraccionamientoValor]));
    Add(Format('Horas Huecas desubicadas:  %13.d %13.0f %10.0f',
        [HoraHuecaDesubicada, Model.HoraHuecaDesubicadaValor,
        HoraHuecaDesubicadaValor]));
    Add(Format('Materias cortadas:         %13.d %13.0f %10.0f',
        [SesionCortada, Model.SesionCortadaValor, SesionCortadaValor]));
    Add(Format('Materias juntas:           %13.d %13.0f %10.0f',
        [MateriaNoDispersa, Model.MateriaNoDispersaValor, MateriaNoDispersaValor]));
    Add(Format('Prohibiciones de materia:  %13s %13s %10.0f',
        ['(' + VarArrToStr(FMateriaProhibicionTipoAMateriaCant, ' ') + ')',
         '(' + VarArrToStr(Model.FMateriaProhibicionTipoAValor, ' ') + ')',
         MateriaProhibicionValor]));
    Add(Format('Prohibiciones de profesor: %13s %13s %10.0f',
        ['(' + VarArrToStr(FProfesorProhibicionTipoAProfesorCant, ' ') + ')',
         '(' + VarArrToStr(Model.FProfesorProhibicionTipoAValor, ' ') + ')',
         ProfesorProhibicionValor]));
    Add('-----------------------------------------------------------------');
    Add(Format('Valor Total:                                           %10.0f', [Value]));
  end;
end;

procedure TTimeTable.InternalMutate;
var
  Paralelo, Periodo1, Periodo2: Integer;
begin
  with Model do
  begin
    Periodo1 := Random(FPeriodoCant);
    Periodo2 := Random(FPeriodoCant);
    Paralelo := Random(FParaleloCant);
    if ParaleloPeriodoASesion[Paralelo, Periodo1]
    <> ParaleloPeriodoASesion[Paralelo, Periodo2] then
      Swap(Paralelo, Periodo1, Periodo2);
  end;
end;

procedure TTimeTable.SetImplementor(const AValue: TObject);
begin
  if FImplementor=AValue then exit;
  FImplementor:=AValue;
end;

procedure TTimeTable.Mutate;
begin
  InternalMutate;
  Update;
end;

procedure TTimeTable.Mutate(Order: Integer);
var
  c: Integer;
begin
  // Check('MutarAntes(...)');
  for c := Random(Order) downto 0 do
    InternalMutate;
  Update;
end;

procedure TTimeTable.MutateDia;
var
  Paralelo, Dia1, Dia2, MinPeriodo1, MinPeriodo2,
    DPeriodo1, DPeriodo2, MaxPeriodo1, MaxPeriodo2: Integer;
  b: TIntegerArray;
  PeriodoASesion: TDynamicIntegerArray;
  DoUpdate: Boolean;
  Count: SizeInt;
begin
  // Check('MutarDiaAntes');
  with Model do
  begin
    Dia1 := Random(FDiaCant);
    repeat
      Dia2 := Random(FDiaCant);
    until Dia1 <> Dia2;
    MinPeriodo1 := FDiaHoraAPeriodo[Dia1, 0];
    MinPeriodo2 := FDiaHoraAPeriodo[Dia2, 0];
    MaxPeriodo1 := FDiaAMaxPeriodo[Dia1];
    MaxPeriodo2 := FDiaAMaxPeriodo[Dia2];
    DPeriodo1 := MaxPeriodo1 - MinPeriodo1;
    DPeriodo2 := MaxPeriodo2 - MinPeriodo2;
    if DPeriodo1 = DPeriodo2 then
    begin
      Count := (DPeriodo1 + 1) * SizeOf(Integer);
      DoUpdate := True;
      for Paralelo := 0 to FParaleloCant - 1 do
      begin
        PeriodoASesion := ParaleloPeriodoASesion[Paralelo];
        if ((MinPeriodo1 = 0)
            or (PeriodoASesion[MinPeriodo1 - 1] < 0)
            or (PeriodoASesion[MinPeriodo1 - 1] <> PeriodoASesion[MinPeriodo1]))
          and ((MinPeriodo2 = 0)
            or (PeriodoASesion[MinPeriodo2 - 1] < 0)
            or (PeriodoASesion[MinPeriodo2 - 1] <> PeriodoASesion[MinPeriodo2]))
          and ((MaxPeriodo1 = FPeriodoCant - 1)
            or (PeriodoASesion[MaxPeriodo1] < 0)
            or (PeriodoASesion[MaxPeriodo1] <> PeriodoASesion[MaxPeriodo1 + 1]))
          and ((MaxPeriodo2 = FPeriodoCant - 1)
            or (PeriodoASesion[MaxPeriodo2] < 0)
            or (PeriodoASesion[MaxPeriodo2] <> PeriodoASesion[MaxPeriodo2 + 1])) then
        begin
          Move(PeriodoASesion[MinPeriodo1], b[0], Count);
          Move(PeriodoASesion[MinPeriodo2], PeriodoASesion[MinPeriodo1], Count);
          Move(b[0], PeriodoASesion[MinPeriodo2], Count);
          DoUpdate := True;
        end;
      end;
      if DoUpdate then
        Update;
    end;
  end;
end;

function TTimeTable.GetHoraHuecaDesubicadaValor: Double;
begin
  Result := Model.FHoraHuecaDesubicadaValor * HoraHuecaDesubicada;
end;

function TTimeTable.GetMateriaProhibicionValor: Double;
var
  MateriaProhibicionTipo: Integer;
begin
  Result := 0;
  with Model, TablingInfo do
  for MateriaProhibicionTipo := 0 to FMateriaProhibicionTipoCant - 1 do
  begin
    Result := Result + FMateriaProhibicionTipoAMateriaCant[MateriaProhibicionTipo]
      * FMateriaProhibicionTipoAValor[MateriaProhibicionTipo];
  end;
end;

function TTimeTable.GetProfesorProhibicionValor: Double;
var
  ProfesorProhibicionTipo: Integer;
begin
  Result := 0;
  with Model, TablingInfo do
  for ProfesorProhibicionTipo := 0 to FProfesorProhibicionTipoCant - 1 do
  begin
    Result := Result + FProfesorProhibicionTipoAProfesorCant[ProfesorProhibicionTipo]
      * FProfesorProhibicionTipoAValor[ProfesorProhibicionTipo];
  end;
end;

function TTimeTable.GetSesionCortadaValor: Double;
begin
  Result := Model.FSesionCortadaValor * SesionCortada;
end;

function TTimeTable.DeltaSesionCortada(Paralelo, Periodo1, Periodo2: Integer): Integer;
var
  Periodo, Hora1, Hora2, Dia1, Dia2, Sesion, Duracion: Integer;
  PeriodoASesion: TDynamicIntegerArray;
begin
  with Model, TablingInfo do
  begin
    Periodo := Periodo1;
    PeriodoASesion := FParaleloPeriodoASesion[Paralelo];
    Result := 0;
    while Periodo <= Periodo2 do
    begin
      Sesion := PeriodoASesion[Periodo];
      Duracion := FSesionADuracion[Sesion];
      if Duracion > 1 then
      begin
        Dia1 := FPeriodoADia[Periodo];
        Dia2 := FPeriodoADia[Periodo + Duracion - 1];
        Hora1 := FPeriodoAHora[Periodo];
        Hora2 := FPeriodoAHora[Periodo + Duracion - 1];
        Inc(Result, (Dia2 - Dia1) * (FHoraCant + 1) + Hora2 - Hora1 + 1 - Duracion);
      end;
      Inc(Periodo, Duracion);
    end;
  end;
end;

function TTimeTable.GetMateriaNoDispersaValor: Double;
begin
  Result := Model.FMateriaNoDispersaValor * MateriaNoDispersa;
end;

function TTimeTable.GetCruceProfesorValor: Double;
begin
  Result := Model.FCruceProfesorValor * TablingInfo.FCruceProfesor;
end;

function TTimeTable.GetCruceMateriaValor: Double;
begin
  Result := Model.FCruceMateriaValor * TablingInfo.FCruceMateria;
end;


function TTimeTable.GetProfesorFraccionamientoValor: Double;
begin
  Result := Model.FProfesorFraccionamientoValor *
    TablingInfo.FProfesorFraccionamiento;
end;

function TTimeTable.GetCruceAulaTipoValor: Double;
begin
  Result := Model.FCruceAulaTipoValor * TablingInfo.FCruceAulaTipo;
end;

function TTimeTable.GetValue: Double;
begin
  with TablingInfo do
    Result :=
      CruceAulaTipoValor +
      CruceProfesorValor +
      CruceMateriaValor +
      HoraHuecaDesubicadaValor +
      MateriaNoDispersaValor +
      MateriaProhibicionValor +
      ProfesorFraccionamientoValor +
      ProfesorProhibicionValor +
      SesionCortadaValor;
end;

function TTimeTable.DownHill(AParalelo: Integer; ExitOnFirstDown: Boolean;
  Threshold: Double): Double;
var
  Periodo1, Periodo2, Duracion1, Duracion2: Integer;
  Delta: Double;
  PeriodoASesion: TDynamicIntegerArray;
begin
  with FModel do
  begin
    Result := 0;
    Periodo1 := 0;
    PeriodoASesion := FParaleloPeriodoASesion[AParalelo];
    while Periodo1 < FPeriodoCant do
    begin
      Duracion1 := SesionADuracion[PeriodoASesion[Periodo1]];
      Periodo2 := Periodo1 + Duracion1;
      while Periodo2 < FPeriodoCant do
      begin
        Duracion2 := SesionADuracion[PeriodoASesion[Periodo2]];
        Delta := InternalSwap(AParalelo, Periodo1, Periodo2);
        if Delta < Threshold then
        begin
          Result := Result + Delta;
          if ExitOnFirstDown then
            Exit;
          Duracion1 := Duracion2;
          Threshold := 0;
        end
        else
        begin
          InternalSwap(AParalelo, Periodo1, Periodo2 + Duracion2 - Duracion1);
        end;
        Inc(Periodo2, Duracion2);
      end;
      Inc(Periodo1, Duracion1);
    end;
  end;
end;

function TTimeTable.DownHill(ExitOnFirstDown, Forced: Boolean;
  Threshold: Double): Double;
var
  Counter, Offset, Paralelo: Integer;
  Delta: Double;
  RandomOrders: array [0 .. 4095] of Integer;
  RandomValues: array [0 .. 4095] of Integer;
begin
  with FModel do
  begin
    for Counter := 0 to FParaleloCant - 1 do
    begin
      RandomOrders[Counter] := Counter;
      RandomValues[Counter] := Random($7FFFFFFF);
    end;
    SortInteger(RandomValues, RandomOrders, 0, FParaleloCant - 1);
    Counter := 0;
    Result := 0;
    Offset := 0;
    while Counter < FParaleloCant do
    begin
      Paralelo := RandomOrders[(Offset + Counter) mod FParaleloCant];
      Delta := DownHill(Paralelo, ExitOnFirstDown, Threshold);
      Inc(Counter);
      if Delta < Threshold then
      begin
        Result := Result + Delta;
        if ExitOnFirstDown then
          Exit;
        Threshold := 0;
        if Forced then
        begin
          Offset := (Offset + Counter) div FParaleloCant;
          Counter := 0;
        end;
      end;
    end;
  end;
end;

{ Retorna verdadero cuando ha descendido }

function TTimeTable.DownHill: Double;
begin
  Result := DownHill(False, False, 0);
end;

function TTimeTable.GetImplementor: TObject;
begin
  Result := Self;
end;

function TTimeTable.DownHillForced: Double;
begin
  Result := DownHill(False, True, 0);
end;

destructor TTimeTable.Destroy;
begin
  FModel := nil;
  inherited Destroy;
end;

procedure TTimeTable.Assign(ATimeTable: TTimeTable);
var
  Paralelo, Materia, Profesor, AulaTipo, Dia: Integer;
begin
  with Model, TablingInfo do
  begin
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      Move(ATimeTable.ParaleloPeriodoASesion[Paralelo, 0],
        ParaleloPeriodoASesion[Paralelo, 0], FPeriodoCant * SizeOf(Integer));
    end;
    FCruceProfesor := ATimeTable.TablingInfo.FCruceProfesor;
    FCruceMateria := ATimeTable.TablingInfo.FCruceMateria;
    FCruceAulaTipo := ATimeTable.TablingInfo.FCruceAulaTipo;
    FProfesorFraccionamiento := ATimeTable.TablingInfo.FProfesorFraccionamiento;
    FHoraHuecaDesubicada := ATimeTable.TablingInfo.FHoraHuecaDesubicada;
    FSesionCortada := ATimeTable.TablingInfo.FSesionCortada;
    FMateriaNoDispersa := ATimeTable.TablingInfo.FMateriaNoDispersa;
    FValue := ATimeTable.TablingInfo.FValue;
    // TablingInfo := ATimeTable.TablingInfo;
    Move(ATimeTable.TablingInfo.FMateriaProhibicionTipoAMateriaCant[0],
      FMateriaProhibicionTipoAMateriaCant[0], FMateriaProhibicionTipoCant * SizeOf(Integer));
    Move(ATimeTable.TablingInfo.FProfesorProhibicionTipoAProfesorCant[0],
      FProfesorProhibicionTipoAProfesorCant[0], FProfesorProhibicionTipoCant * SizeOf(Integer));
    for Materia := 0 to FMateriaCant - 1 do
      Move(ATimeTable.TablingInfo.FMateriaPeriodoCant[Materia, 0],
           TablingInfo.FMateriaPeriodoCant[Materia, 0],
           FPeriodoCant * SizeOf(Integer));
    for Profesor := 0 to FProfesorCant - 1 do
      Move(ATimeTable.TablingInfo.FProfesorPeriodoCant[Profesor, 0],
           TablingInfo.FProfesorPeriodoCant[Profesor, 0],
           FPeriodoCant * SizeOf(Integer));
    for Dia := 0 to FDiaCant - 1 do
    begin
      Move(ATimeTable.TablingInfo.FDiaProfesorFraccionamiento[Dia, 0],
        FDiaProfesorFraccionamiento[Dia, 0], FProfesorCant * SizeOf(Integer));
    end;
    for AulaTipo := 0 to FAulaTipoCant - 1 do
      Move(ATimeTable.TablingInfo.FAulaTipoPeriodoCant[AulaTipo, 0],
        TablingInfo.FAulaTipoPeriodoCant[AulaTipo, 0],
        FPeriodoCant * SizeOf(Integer));
    for Paralelo := 0 to FParaleloCant - 1 do
      for Dia := 0 to FDiaCant - 1 do
      begin
        Move(ATimeTable.TablingInfo.FParaleloDiaMateriaCant[Paralelo, Dia, 0],
          TablingInfo.FParaleloDiaMateriaCant[Paralelo, Dia, 0],
          FMateriaCant * SizeOf(Integer));
        Move(ATimeTable.TablingInfo.FParaleloDiaMateriaAcum[Paralelo, Dia, 0],
          TablingInfo.FParaleloDiaMateriaAcum[Paralelo, Dia, 0],
          FMateriaCant * SizeOf(Integer));
      end;
  end;
end;

procedure TTimeTable.SaveToFile(const AFileName: string);
var
  VStrings: TStrings;
  Paralelo, Periodo: Integer;
begin
  VStrings := TStringList.Create;
  with Model do
    try
      for Paralelo := 0 to FParaleloCant - 1 do
      begin
        VStrings.Add(Format('Paralelo %d %d %d',
            [FNivelACodNivel[FParaleloANivel[Paralelo]],
            FEspecializacionACodEspecializacion[FParaleloAEspecializacion[Paralelo]],
            FParaleloIdACodParaleloId[FParaleloAParaleloId[Paralelo]]]));
        for Periodo := 0 to FPeriodoCant - 1 do
        begin
          VStrings.Add(Format(' Dia %d Hora %d Materia %d', [FPeriodoADia[Periodo],
              FPeriodoAHora[Periodo],
              FMateriaACodMateria[FSesionAMateria[ParaleloPeriodoASesion[
                Paralelo, Periodo]]]]));
        end;
      end;
      VStrings.SaveToFile(AFileName);
    finally
      VStrings.Free;
    end;
end;

procedure TTimeTable.SaveToStream(Stream: TStream);
var
  Paralelo: Integer;
begin
  with FModel do
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      Stream.Write(ParaleloPeriodoASesion[Paralelo, 0], FPeriodoCant * SizeOf(Integer));
    end;
end;

procedure TTimeTable.LoadFromStream(Stream: TStream);
var
  Paralelo: Integer;
begin
  with FModel do
    for Paralelo := 0 to FParaleloCant - 1 do
    begin
      Stream.Read(ParaleloPeriodoASesion[Paralelo, 0], FPeriodoCant * SizeOf(Integer));
    end;
  Update;
end;

procedure TTimeTable.SaveToDataModule(CodHorario: Integer;
  MomentoInicial, MomentoFinal: TDateTime; Informe: TStrings);
var
  {$IFDEF USE_SQL}
  SQL: TStrings;
  {$ENDIF}
  procedure SaveHorario;
  {$IFNDEF USE_SQL}
  var
    Stream: TStream;
  {$ENDIF}
  begin
    {$IFDEF USE_SQL}
    SQL.Add(Format('INSERT INTO Horario(CodHorario,MomentoInicial,MomentoFinal,Informe) ' +
      'VALUES (%d,"%s","%s","%s");', [
      CodHorario,
      DateTimeToAnsiSQLDate(MomentoInicial),
      DateTimeToAnsiSQLDate(MomentoFinal),
      Informe.Text]));
    {$ELSE}
    with SourceDataModule, TbHorario do
    begin
      DisableControls;
      try
        IndexFieldNames := 'CodHorario';
        Append;
        TbHorario.FindField('CodHorario').AsInteger := CodHorario;
        TbHorario.FindField('MomentoInicial').AsDateTime := MomentoInicial;
        TbHorario.FindField('MomentoFinal').AsDateTime := MomentoFinal;
        Stream := TMemoryStream.Create;
        try
          Informe.SaveToStream(Stream);
          Stream.Position := 0;
          TBlobField(TbHorario.FindField('Informe')).LoadFromStream(Stream);
        finally
          Stream.Free;
        end;
        Post;
      finally
        EnableControls;
      end;
    end;
    {$ENDIF}
  end;
  procedure SaveHorarioDetalle;
  var
    Paralelo, Periodo, CodNivel, CodParaleloId, CodEspecializacion, Sesion: Integer;
    {$IFNDEF USE_SQL}
    FieldHorario, FieldNivel, FieldParaleloId, FieldEspecializacion, FieldDia,
      FieldHora, FieldMateria, FieldSesion: TField;
    {$ENDIF}
  begin
  {$IFDEF USE_SQL}
      with Model do
      for Paralelo := 0 to FParaleloCant - 1 do
      begin
        CodNivel := FNivelACodNivel[FParaleloANivel[Paralelo]];
        CodParaleloId := FParaleloIdACodParaleloId[FParaleloAParaleloId[Paralelo]];
        CodEspecializacion := FEspecializacionACodEspecializacion
          [FParaleloAEspecializacion[Paralelo]];
        for Periodo := 0 to FPeriodoCant - 1 do
        begin
          Sesion := ParaleloPeriodoASesion[Paralelo, Periodo];
          if Sesion >= 0 then
          begin
            SQL.Add(Format(
              'INSERT INTO HorarioDetalle' +
              '(CodHorario,CodNivel,CodParaleloId,CodEspecializacion,CodDia,' +
              'CodHora,CodMateria,Sesion) VALUES (%d,%d,%d,%d,%d,%d,%d,%d);',
              [CodHorario, CodNivel, CodParaleloId, CodEspecializacion,
              FDiaACodDia[FPeriodoADia[Periodo]],
              FHoraACodHora[FPeriodoAHora[Periodo]],
              FMateriaACodMateria[FSesionAMateria[Sesion]],
              Sesion]));
          end;
        end;
      end;
    {$ELSE}
    with SourceDataModule.TbHorarioDetalle do
    begin
      DisableControls;
      try
        Last;
        FieldHorario := FindField('CodHorario');
        FieldNivel := FindField('CodNivel');
        FieldParaleloId := FindField('CodParaleloId');
        FieldEspecializacion := FindField('CodEspecializacion');
        FieldDia := FindField('CodDia');
        FieldHora := FindField('CodHora');
        FieldMateria := FindField('CodMateria');
        FieldSesion := FindField('Sesion');
        with TimeTableModel do
        for Paralelo := 0 to FParaleloCant - 1 do
        begin
          CodNivel := FNivelACodNivel[FParaleloANivel[Paralelo]];
          CodParaleloId := FParaleloIdACodParaleloId[FParaleloAParaleloId[Paralelo]];
          CodEspecializacion := FEspecializacionACodEspecializacion
            [FParaleloAEspecializacion[Paralelo]];
          for Periodo := 0 to FPeriodoCant - 1 do
          begin
            Sesion := ParaleloPeriodoASesion[Paralelo, Periodo];
            if Sesion >= 0 then
            begin
              Append;
              FieldHorario.AsInteger := CodHorario;
              FieldNivel.AsInteger := CodNivel;
              FieldParaleloId.AsInteger := CodParaleloId;
              FieldEspecializacion.AsInteger := CodEspecializacion;
              FieldDia.AsInteger := FDiaACodDia[FPeriodoADia[Periodo]];
              FieldHora.AsInteger := FHoraACodHora[FPeriodoAHora[Periodo]];
              FieldMateria.AsInteger := FMateriaACodMateria[FSesionAMateria[Sesion]];
              FieldSesion.AsInteger := Sesion;
              Post;
            end;
          end;
        end;
      finally
        EnableControls;
      end;
    end;
    {$ENDIF}
  end;
begin
  {$IFDEF USE_SQL}
  SQL := TStringList.Create;
  {$ELSE}
  SourceDataModule.CheckRelations := False;
  {$ENDIF}
  try
    SaveHorario;
    SaveHorarioDetalle;
    {$IFDEF USE_SQL}
    with SourceDataModule do
    begin
      Database.ExecuteDirect(SQL.Text);
      TbHorario.Refresh;
      TbHorarioDetalle.Refresh;
    end;
    {$ENDIF}
  finally
    {$IFDEF USE_SQL}
    SQL.Free;
    {$ELSE}
    SourceDataModule.CheckRelations := True;
    {$ENDIF};
  end;
end;

function TTimeTable.GetDiaProfesorFraccionamiento(Dia, Profesor: Integer): Integer;
var
  Periodo, Max, Min, Count, MaxPeriodo: Integer;
  VPeriodoCant: TDynamicIntegerArray;
  PeriodoAProfesorProhibicionTipo: TDynamicIntegerArray;
begin
  Count := 0;
  Max := -1;
  Min := 32767;
  with Model, TablingInfo do
  begin
    MaxPeriodo := FDiaAMaxPeriodo[Dia];
    VPeriodoCant := @FProfesorPeriodoCant[Profesor, 0];
    PeriodoAProfesorProhibicionTipo := FProfesorPeriodoAProfesorProhibicionTipo[Profesor];
    for Periodo := FDiaHoraAPeriodo[Dia, 0] to MaxPeriodo do
    begin
      if (VPeriodoCant[Periodo] > 0)
        or (FProfesorProhibicionTipoAValor[PeriodoAProfesorProhibicionTipo[Periodo]] =
          FMaxProfesorProhibicionTipoValor) then
      begin
        Max := FPeriodoAHora[Periodo];
        Inc(Count);
        if Min > Max then
          Min := Max;
      end;
    end;
  end;
  if Count = 0 then
    Result := 0
  else
    Result := Max - Min + 1 - Count;
end;

procedure TTimeTable.LoadFromDataModule(CodHorario: Integer);
var
  FieldNivel, FieldParaleloId, FieldEspecializacion, FieldDia, FieldHora,
    FieldSesion: TLongintField;
  Paralelo, Periodo: Integer;
begin
  with SourceDataModule, Model, TbHorarioDetalle do
  begin
    TbHorario.Locate('CodHorario', CodHorario, []);
    LinkedFields := 'CodHorario';
    MasterFields := 'CodHorario';
    MasterSource := DSHorario;
    try
      FieldNivel := FindField('CodNivel') as TLongintField;
      FieldParaleloId := FindField('CodParaleloId') as TLongintField;
      FieldEspecializacion := FindField('CodEspecializacion') as TLongintField;
      FieldDia := FindField('CodDia') as TLongintField;
      FieldHora := FindField('CodHora') as TLongintField;
      FieldSesion := FindField('Sesion') as TLongintField;
      for Paralelo := 0 to FParaleloCant - 1 do
        for Periodo := 0 to FPeriodoCant - 1 do
          FParaleloPeriodoASesion[Paralelo, Periodo] := -1;
      First;
      while not Eof do
      begin
        Paralelo := FCursoParaleloIdAParalelo[
          FNivelEspecializacionACurso[
            FCodNivelANivel[FieldNivel.AsInteger - FMinCodNivel],
            FCodEspecializacionAEspecializacion[FieldEspecializacion.AsInteger -
            FMinCodEspecializacion]],
          FCodParaleloIdAParaleloId[FieldParaleloId.AsInteger -
          FMinCodParaleloId]];
        Periodo := FDiaHoraAPeriodo[FCodDiaADia[FieldDia.AsInteger - FMinCodDia],
          FCodHoraAHora[FieldHora.AsInteger - FMinCodHora]];
        FParaleloPeriodoASesion[Paralelo, Periodo] := FieldSesion.AsInteger;
        Next;
      end;
    finally
      MasterSource := nil;
      MasterFields := '';
      LinkedFields := '';
    end;
  end;
  Update;
  CheckIntegrity;
end;

procedure TTimeTable.CheckIntegrity;
var
  Materia, Paralelo, Periodo, AulaTipo, Profesor, Distributivo, Counter,
    Sesion: Integer;
  SesionFound: Boolean;
begin
  with Model, TablingInfo do
  begin
    for Paralelo := 0 to FParaleloCant - 1 do
      for Periodo := 0 to FPeriodoCant - 1 do
      begin
        Sesion := FParaleloPeriodoASesion[Paralelo, Periodo];
        if Sesion >= 0 then
        begin
          Materia := FSesionAMateria[Sesion];
          Profesor := FParaleloMateriaAProfesor[Paralelo, Materia];
          if Profesor < 0 then
            raise Exception.CreateFmt('Paralelo %d(%d,%d,%d), Materia %d(%d) no tiene Profesor', [
              Paralelo,
              FNivelACodNivel[FParaleloANivel[Paralelo]],
              FEspecializacionACodEspecializacion[FParaleloAEspecializacion[Paralelo]],
              FParaleloIdACodParaleloId[FParaleloAParaleloId[Paralelo]],
              Materia,
              FMateriaACodMateria[Materia]]);
          AulaTipo := FSesionAAulaTipo[Sesion];
          Distributivo := FParaleloMateriaADistributivo[Paralelo, Materia];
          // FDistributivoAAulaTipo[Distributivo]
          SesionFound := False;
          for Counter := 0 to High(FDistributivoASesiones[Distributivo]) do
            SesionFound := SesionFound or (FDistributivoASesiones[Distributivo, Counter] = Sesion);
          if not SesionFound then
            raise Exception.CreateFmt('Paralelo %d(%d,%d,%d), Materia %d(%d) no aparece en FDistributivoASesiones', [
              Paralelo,
              FNivelACodNivel[FParaleloANivel[Paralelo]],
              FEspecializacionACodEspecializacion[FParaleloAEspecializacion[Paralelo]],
              FParaleloIdACodParaleloId[FParaleloAParaleloId[Paralelo]],
              Materia,
              FMateriaACodMateria[Materia]]);
          if Distributivo < 0 then
            raise Exception.CreateFmt('Paralelo %d(%d,%d,%d), Materia %d(%d) no aparece en FParaleloMateriaADistributivo', [
              Paralelo,
              FNivelACodNivel[FParaleloANivel[Paralelo]],
              FEspecializacionACodEspecializacion[FParaleloAEspecializacion[Paralelo]],
              FParaleloIdACodParaleloId[FParaleloAParaleloId[Paralelo]],
              Materia,
              FMateriaACodMateria[Materia]]);
        end;
      end;
  end;
end;

procedure TTimeTable.Reset;
var
  Profesor, Periodo, Materia, MateriaProhibicionTipo, ProfesorProhibicionTipo,
    Paralelo, Dia, AulaTipo: Integer;
begin
  with Model, TablingInfo do
  begin
    FCruceProfesor := 0;
    FCruceMateria := 0;
    FCruceAulaTipo := 0;
    FHoraHuecaDesubicada := 0;
    FProfesorFraccionamiento := 0;
    FSesionCortada := 0;
    FMateriaNoDispersa := 0;
    for Dia := 0 to FDiaCant - 1 do
      for Profesor := 0 to FProfesorCant - 1 do
        FDiaProfesorFraccionamiento[Dia, Profesor] := 0;
    for MateriaProhibicionTipo := 0 to FMateriaProhibicionTipoCant - 1 do
      FMateriaProhibicionTipoAMateriaCant[MateriaProhibicionTipo] := 0;
    for ProfesorProhibicionTipo := 0 to FProfesorProhibicionTipoCant - 1 do
      FProfesorProhibicionTipoAProfesorCant[ProfesorProhibicionTipo] := 0;
    for Periodo := 0 to FPeriodoCant - 1 do
    begin
      for Profesor := 0 to FProfesorCant - 1 do
        FProfesorPeriodoCant[Profesor, Periodo] := 0;
      for Materia := 0 to FMateriaCant - 1 do
        FMateriaPeriodoCant[Materia, Periodo] := 0;
      for AulaTipo := 0 to FAulaTipoCant - 1 do
        FAulaTipoPeriodoCant[AulaTipo, Periodo] := 0;
    end;
    for Paralelo := 0 to FParaleloCant - 1 do
      for Dia := 0 to FDiaCant - 1 do
        for Materia := 0 to FMateriaCant - 1 do
        begin
          FParaleloDiaMateriaCant[Paralelo, Dia, Materia] := 0;
          FParaleloDiaMateriaAcum[Paralelo, Dia, Materia] := 0;
        end;
  end;
end;

procedure TTimeTable.Update;
var
  Dia, Paralelo, Profesor: Integer;
  ActualizarDiaProfesor: TDynamicBooleanArrayArray;
begin
  with Model, TablingInfo do
  begin
    SetLength(ActualizarDiaProfesor, FDiaCant, FProfesorCant);
    for Dia := 0 to FDiaCant - 1 do
      for Profesor := 0 to FProfesorCant - 1 do
        ActualizarDiaProfesor[Dia, Profesor] := True;
    Reset;
    for Paralelo := 0 to FParaleloCant - 1 do
      DeltaValues(1, Paralelo, 0, FPeriodoCant - 1, ActualizarDiaProfesor);
    UpdateProfesorFraccionamiento(ActualizarDiaProfesor);
    FValue := GetValue;
  end
end;

destructor TTimeTableModel.Destroy;
begin
  inherited Destroy;
end;

class function TTimeTableModel.GetElitistCount: Integer;
begin
  Result := 3;
end;

initialization

// SortLongint := QuicksortInteger;
// lSort := lQuicksort;
SortInteger := BubblesortInteger;
lSort := lBubblesort;

end.

