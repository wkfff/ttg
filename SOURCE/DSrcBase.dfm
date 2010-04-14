inherited SourceBaseDataModule: TSourceBaseDataModule
  OldCreateOrder = True
  object TbAulaTipo: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbAulaTipoixAbrAulaTipo'
        Fields = 'AbrAulaTipo'
        Options = [ixUnique]
      end
      item
        Name = 'TbAulaTipoixNomAulaTipo'
        Fields = 'NomAulaTipo'
        Options = [ixUnique]
      end
      item
        Name = 'TbAulaTipoPrimaryKey'
        Fields = 'CodAulaTipo'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbAulaTipoBeforePost
    BeforeDelete = TbAulaTipoBeforeDelete
    Left = 48
    Top = 48
    object TbAulaTipoCodAulaTipo: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodAulaTipo'
    end
    object TbAulaTipoNomAulaTipo: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomAulaTipo'
      Required = True
      Size = 25
    end
    object TbAulaTipoAbrAulaTipo: TStringField
      DisplayLabel = 'Abreviatura'
      FieldName = 'AbrAulaTipo'
      Required = True
      Size = 10
    end
    object TbAulaTipoCantidad: TIntegerField
      FieldName = 'Cantidad'
      Required = True
    end
  end
  object dsAulaTipo: TDataSource
    DataSet = TbAulaTipo
    Left = 56
    Top = 40
  end
  object TbEspecializacion: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbEspecializacionixAbrEspecializacion'
        Fields = 'AbrEspecializacion'
        Options = [ixUnique]
      end
      item
        Name = 'TbEspecializacionixNomEspecializacion'
        Fields = 'NomEspecializacion'
        Options = [ixUnique]
      end
      item
        Name = 'TbEspecializacionPrimaryKey'
        Fields = 'CodEspecializacion'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbEspecializacionBeforePost
    BeforeDelete = TbEspecializacionBeforeDelete
    Left = 144
    Top = 60
    object TbEspecializacionCodEspecializacion: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodEspecializacion'
    end
    object TbEspecializacionNomEspecializacion: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomEspecializacion'
      Required = True
    end
    object TbEspecializacionAbrEspecializacion: TStringField
      DisplayLabel = 'Abreviatura'
      FieldName = 'AbrEspecializacion'
      Required = True
      Size = 10
    end
  end
  object dsEspecializacion: TDataSource
    DataSet = TbEspecializacion
    Left = 152
    Top = 52
  end
  object TbDia: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbDiaixNomDia'
        Fields = 'NomDia'
        Options = [ixUnique]
      end
      item
        Name = 'TbDiaPrimaryKey'
        Fields = 'CodDia'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbDiaBeforePost
    BeforeDelete = TbDiaBeforeDelete
    Left = 240
    Top = 48
    object TbDiaCodDia: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodDia'
    end
    object TbDiaNomDia: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomDia'
      Required = True
      Size = 10
    end
  end
  object dsDia: TDataSource
    DataSet = TbDia
    Left = 248
    Top = 40
  end
  object TbMateria: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbMateriaixNomMateria'
        Fields = 'NomMateria'
        Options = [ixUnique]
      end
      item
        Name = 'TbMateriaPrimaryKey'
        Fields = 'CodMateria'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbMateriaBeforePost
    BeforeDelete = TbMateriaBeforeDelete
    Left = 336
    Top = 60
    object TbMateriaCodMateria: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodMateria'
    end
    object TbMateriaNomMateria: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomMateria'
      Required = True
    end
  end
  object dsMateria: TDataSource
    DataSet = TbMateria
    Left = 344
    Top = 52
  end
  object TbNivel: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbNivelixAbrNivel'
        Fields = 'AbrNivel'
        Options = [ixUnique]
      end
      item
        Name = 'TbNivelixNomNivel'
        Fields = 'NomNivel'
        Options = [ixUnique]
      end
      item
        Name = 'TbNivelPrimaryKey'
        Fields = 'CodNivel'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbNivelBeforePost
    BeforeDelete = TbNivelBeforeDelete
    Left = 432
    Top = 48
    object TbNivelCodNivel: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodNivel'
    end
    object TbNivelNomNivel: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomNivel'
      Required = True
      Size = 15
    end
    object TbNivelAbrNivel: TStringField
      DisplayLabel = 'Abreviatura'
      FieldName = 'AbrNivel'
      Size = 5
    end
  end
  object dsNivel: TDataSource
    DataSet = TbNivel
    Left = 440
    Top = 40
  end
  object TbHora: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbHoraixIntervalo'
        Fields = 'Intervalo'
        Options = [ixUnique]
      end
      item
        Name = 'TbHoraixNomHora'
        Fields = 'NomHora'
        Options = [ixUnique]
      end
      item
        Name = 'TbHoraPrimaryKey'
        Fields = 'CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbHoraBeforePost
    BeforeDelete = TbHoraBeforeDelete
    Left = 48
    Top = 144
    object TbHoraCodHora: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodHora'
    end
    object TbHoraNomHora: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomHora'
      Required = True
      Size = 10
    end
    object TbHoraIntervalo: TStringField
      FieldName = 'Intervalo'
      Required = True
      Size = 21
    end
  end
  object dsHora: TDataSource
    DataSet = TbHora
    Left = 56
    Top = 136
  end
  object TbHorario: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbHorarioixMomentoFinal'
        Fields = 'MomentoFinal'
      end
      item
        Name = 'TbHorarioixMomentoInicial'
        Fields = 'MomentoInicial'
      end
      item
        Name = 'TbHorarioPrimaryKey'
        Fields = 'CodHorario'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbHorarioBeforePost
    BeforeDelete = TbHorarioBeforeDelete
    Left = 144
    Top = 156
    object TbHorarioCodHorario: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodHorario'
    end
    object TbHorarioMomentoInicial: TDateTimeField
      DisplayLabel = 'Momento Inicial'
      FieldName = 'MomentoInicial'
      Required = True
    end
    object TbHorarioMomentoFinal: TDateTimeField
      DisplayLabel = 'Momento Final'
      FieldName = 'MomentoFinal'
      Required = True
    end
    object TbHorarioInforme: TMemoField
      FieldName = 'Informe'
      BlobType = ftMemo
    end
  end
  object dsHorario: TDataSource
    DataSet = TbHorario
    Left = 152
    Top = 148
  end
  object TbCurso: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbCursoEspecializacionCurso'
        Fields = 'CodEspecializacion'
      end
      item
        Name = 'TbCursoNivelCurso'
        Fields = 'CodNivel'
      end
      item
        Name = 'TbCursoPrimaryKey'
        Fields = 'CodNivel;CodEspecializacion'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbCursoBeforePost
    BeforeDelete = TbCursoBeforeDelete
    Left = 240
    Top = 144
    object TbCursoCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object TbCursoCodEspecializacion: TIntegerField
      DisplayLabel = 'Especializaci'#243'n'
      FieldName = 'CodEspecializacion'
      Required = True
    end
  end
  object dsCurso: TDataSource
    DataSet = TbCurso
    Left = 248
    Top = 136
  end
  object TbParaleloId: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbParaleloIdixNomParaleloId'
        Fields = 'NomParaleloId'
        Options = [ixUnique]
      end
      item
        Name = 'TbParaleloIdPrimaryKey'
        Fields = 'CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbParaleloIdBeforePost
    BeforeDelete = TbParaleloIdBeforeDelete
    Left = 336
    Top = 156
    object TbParaleloIdCodParaleloId: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodParaleloId'
    end
    object TbParaleloIdNomParaleloId: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomParaleloId'
      Required = True
      Size = 5
    end
  end
  object dsParaleloId: TDataSource
    DataSet = TbParaleloId
    Left = 344
    Top = 148
  end
  object TbMateriaProhibicionTipo: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbMateriaProhibicionTipoixNomMateProhibicionTipo'
        Fields = 'NomMateProhibicionTipo'
        Options = [ixUnique]
      end
      item
        Name = 'TbMateriaProhibicionTipoPrimaryKey'
        Fields = 'CodMateProhibicionTipo'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbMateriaProhibicionTipoBeforePost
    BeforeDelete = TbMateriaProhibicionTipoBeforeDelete
    Left = 432
    Top = 144
    object TbMateriaProhibicionTipoCodMateProhibicionTipo: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodMateProhibicionTipo'
      Required = True
    end
    object TbMateriaProhibicionTipoNomMateProhibicionTipo: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomMateProhibicionTipo'
      Required = True
      Size = 10
    end
    object TbMateriaProhibicionTipoColMateProhibicionTipo: TIntegerField
      DisplayLabel = 'Color'
      FieldName = 'ColMateProhibicionTipo'
      Required = True
    end
    object TbMateriaProhibicionTipoValMateProhibicionTipo: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'ValMateProhibicionTipo'
      Required = True
    end
  end
  object dsMateriaProhibicionTipo: TDataSource
    DataSet = TbMateriaProhibicionTipo
    Left = 440
    Top = 136
  end
  object TbPeriodo: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbPeriodoDiaPeriodo'
        Fields = 'CodDia'
      end
      item
        Name = 'TbPeriodoHoraPeriodo'
        Fields = 'CodHora'
      end
      item
        Name = 'TbPeriodoPrimaryKey'
        Fields = 'CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbPeriodoBeforePost
    BeforeDelete = TbPeriodoBeforeDelete
    Left = 48
    Top = 240
    object TbPeriodoCodDia: TIntegerField
      DisplayLabel = 'D'#237'a'
      FieldName = 'CodDia'
      Required = True
    end
    object TbPeriodoCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
  end
  object dsPeriodo: TDataSource
    DataSet = TbPeriodo
    Left = 56
    Top = 232
  end
  object TbParalelo: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbParaleloCursoParalelo'
        Fields = 'CodNivel;CodEspecializacion'
      end
      item
        Name = 'TbParaleloParaleloIdParalelo'
        Fields = 'CodParaleloId'
      end
      item
        Name = 'TbParaleloPrimaryKey'
        Fields = 'CodNivel;CodEspecializacion;CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbParaleloBeforePost
    BeforeDelete = TbParaleloBeforeDelete
    Left = 144
    Top = 252
    object TbParaleloCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object TbParaleloCodEspecializacion: TIntegerField
      DisplayLabel = 'Especializaci'#243'n'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object TbParaleloCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
    end
  end
  object dsParalelo: TDataSource
    DataSet = TbParalelo
    Left = 152
    Top = 244
  end
  object TbProfesor: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbProfesorixApeNomProfesor'
        Fields = 'ApeProfesor;NomProfesor'
        Options = [ixUnique]
      end
      item
        Name = 'TbProfesorixNomApeProfesor'
        Fields = 'NomProfesor;ApeProfesor'
        Options = [ixUnique]
      end
      item
        Name = 'TbProfesorPrimaryKey'
        Fields = 'CodProfesor'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbProfesorBeforePost
    BeforeDelete = TbProfesorBeforeDelete
    Left = 240
    Top = 240
    object TbProfesorCodProfesor: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodProfesor'
    end
    object TbProfesorCedProfesor: TStringField
      DisplayLabel = 'C'#233'dula'
      FieldName = 'CedProfesor'
      Required = True
      Size = 11
    end
    object TbProfesorApeProfesor: TStringField
      DisplayLabel = 'Apellido'
      FieldName = 'ApeProfesor'
      Required = True
      Size = 15
    end
    object TbProfesorNomProfesor: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomProfesor'
      Required = True
      Size = 15
    end
  end
  object dsProfesor: TDataSource
    DataSet = TbProfesor
    Left = 248
    Top = 232
  end
  object TbMateriaProhibicion: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbMateriaProhibicionMateriaMateriaProhibicion'
        Fields = 'CodMateria'
      end
      item
        Name = 'TbMateriaProhibicionMateriaProhibicionTipoMateriaProhibicion'
        Fields = 'CodMateProhibicionTipo'
      end
      item
        Name = 'TbMateriaProhibicionPeriodoMateriaProhibicion'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'TbMateriaProhibicionPrimaryKey'
        Fields = 'CodMateria;CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbMateriaProhibicionBeforePost
    Left = 336
    Top = 252
    object TbMateriaProhibicionCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object TbMateriaProhibicionCodDia: TIntegerField
      DisplayLabel = 'D'#237'a'
      FieldName = 'CodDia'
      Required = True
    end
    object TbMateriaProhibicionCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
    object TbMateriaProhibicionCodMateProhibicionTipo: TIntegerField
      DisplayLabel = 'Tipo de Prohibici'#243'n'
      FieldName = 'CodMateProhibicionTipo'
      Required = True
    end
  end
  object dsMateriaProhibicion: TDataSource
    DataSet = TbMateriaProhibicion
    Left = 344
    Top = 244
  end
  object TbDistributivo: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbDistributivoAulaTipoDistributivo'
        Fields = 'CodAulaTipo'
      end
      item
        Name = 'TbDistributivoMateriaDistributivo'
        Fields = 'CodMateria'
      end
      item
        Name = 'TbDistributivoParaleloDistributivo'
        Fields = 'CodNivel;CodEspecializacion;CodParaleloId'
      end
      item
        Name = 'TbDistributivoPrimaryKey'
        Fields = 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'TbDistributivoProfesorDistributivo'
        Fields = 'CodProfesor'
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbDistributivoBeforePost
    BeforeDelete = TbDistributivoBeforeDelete
    Left = 432
    Top = 240
    object TbDistributivoCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object TbDistributivoCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object TbDistributivoCodEspecializacion: TIntegerField
      DisplayLabel = 'Especializaci'#243'n'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object TbDistributivoCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
    end
    object TbDistributivoCodProfesor: TIntegerField
      DisplayLabel = 'Profesor'
      FieldName = 'CodProfesor'
      Required = True
    end
    object TbDistributivoCodAulaTipo: TIntegerField
      DisplayLabel = 'Tipo de Aula'
      FieldName = 'CodAulaTipo'
      Required = True
    end
    object TbDistributivoComposicion: TStringField
      DisplayLabel = 'Composici'#243'n'
      FieldName = 'Composicion'
      Required = True
      Size = 40
    end
  end
  object dsDistributivo: TDataSource
    DataSet = TbDistributivo
    Left = 440
    Top = 232
  end
  object TbHorarioDetalle: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbHorarioDetalleDistributivoHorarioDetalle'
        Fields = 'CodMateria;CodNivel;CodEspecializacion;CodParaleloId'
      end
      item
        Name = 'TbHorarioDetalleHorarioDetalleCodMateria'
        Fields = 'CodMateria'
      end
      item
        Name = 'TbHorarioDetalleHorarioHorarioDetalle'
        Fields = 'CodHorario'
      end
      item
        Name = 'TbHorarioDetalleixRestriccionMateria'
        Fields = 
          'CodHorario;CodNivel;CodEspecializacion;CodParaleloId;CodDia;CodH' +
          'ora'
        Options = [ixUnique]
      end
      item
        Name = 'TbHorarioDetallePeriodoHorarioDetalle'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'TbHorarioDetallePrimaryKey'
        Fields = 
          'CodHorario;CodMateria;CodNivel;CodEspecializacion;CodParaleloId;' +
          'CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbHorarioDetalleBeforePost
    Left = 48
    Top = 336
    object TbHorarioDetalleCodHorario: TIntegerField
      DisplayLabel = 'Horario'
      FieldName = 'CodHorario'
      Required = True
    end
    object TbHorarioDetalleCodMateria: TIntegerField
      DisplayLabel = 'Materia'
      FieldName = 'CodMateria'
      Required = True
    end
    object TbHorarioDetalleCodNivel: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'CodNivel'
      Required = True
    end
    object TbHorarioDetalleCodEspecializacion: TIntegerField
      DisplayLabel = 'Especializaci'#243'n'
      FieldName = 'CodEspecializacion'
      Required = True
    end
    object TbHorarioDetalleCodParaleloId: TIntegerField
      DisplayLabel = 'Paralelo'
      FieldName = 'CodParaleloId'
      Required = True
    end
    object TbHorarioDetalleCodDia: TIntegerField
      DisplayLabel = 'D'#237'a'
      FieldName = 'CodDia'
      Required = True
    end
    object TbHorarioDetalleCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
    object TbHorarioDetalleSesion: TIntegerField
      DisplayLabel = 'Sesi'#243'n'
      FieldName = 'Sesion'
      Required = True
    end
  end
  object dsHorarioDetalle: TDataSource
    DataSet = TbHorarioDetalle
    Left = 56
    Top = 328
  end
  object TbProfesorProhibicionTipo: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbProfesorProhibicionTipoixNomProfProhibicionTipo'
        Fields = 'NomProfProhibicionTipo'
        Options = [ixUnique]
      end
      item
        Name = 'TbProfesorProhibicionTipoPrimaryKey'
        Fields = 'CodProfProhibicionTipo'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbProfesorProhibicionTipoBeforePost
    BeforeDelete = TbProfesorProhibicionTipoBeforeDelete
    Left = 144
    Top = 348
    object TbProfesorProhibicionTipoCodProfProhibicionTipo: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CodProfProhibicionTipo'
    end
    object TbProfesorProhibicionTipoNomProfProhibicionTipo: TStringField
      DisplayLabel = 'Nombre'
      FieldName = 'NomProfProhibicionTipo'
      Required = True
      Size = 10
    end
    object TbProfesorProhibicionTipoColProfProhibicionTipo: TIntegerField
      DisplayLabel = 'Color'
      FieldName = 'ColProfProhibicionTipo'
      Required = True
    end
    object TbProfesorProhibicionTipoValProfProhibicionTipo: TFloatField
      DisplayLabel = 'Valor'
      FieldName = 'ValProfProhibicionTipo'
      Required = True
    end
  end
  object dsProfesorProhibicionTipo: TDataSource
    DataSet = TbProfesorProhibicionTipo
    Left = 152
    Top = 340
  end
  object TbProfesorProhibicion: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'TbProfesorProhibicionPeriodoProfesorProhibicion'
        Fields = 'CodDia;CodHora'
      end
      item
        Name = 'TbProfesorProhibicionPrimaryKey'
        Fields = 'CodProfesor;CodDia;CodHora'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'TbProfesorProhibicionProfesorProfesorProhibicion'
        Fields = 'CodProfesor'
      end
      item
        Name = 'TbProfesorProhibicionProfesorProhibicionTipoProfesorProhibicion'
        Fields = 'CodProfProhibicionTipo'
      end>
    SortOptions = []
    AllDataOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveBlobs, mtfSaveFiltered, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail, mtfSaveDeltas]
    CommaTextOptions = [mtfSaveData]
    CSVQuote = '"'
    CSVFieldDelimiter = ','
    CSVRecordDelimiter = ','
    CSVTrueString = 'True'
    CSVFalseString = 'False'
    PersistentSaveOptions = [mtfSaveData, mtfSaveNonVisible, mtfSaveIgnoreRange, mtfSaveIgnoreMasterDetail]
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    FilterOptions = []
    Version = '2.53b'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    BeforePost = TbProfesorProhibicionBeforePost
    Left = 240
    Top = 336
    object TbProfesorProhibicionCodProfesor: TIntegerField
      DisplayLabel = 'Profesor'
      FieldName = 'CodProfesor'
      Required = True
    end
    object TbProfesorProhibicionCodDia: TIntegerField
      DisplayLabel = 'D'#237'a'
      FieldName = 'CodDia'
      Required = True
    end
    object TbProfesorProhibicionCodHora: TIntegerField
      DisplayLabel = 'Hora'
      FieldName = 'CodHora'
      Required = True
    end
    object TbProfesorProhibicionCodProfProhibicionTipo: TIntegerField
      DisplayLabel = 'Tipo de prohibici'#243'n'
      FieldName = 'CodProfProhibicionTipo'
      Required = True
    end
  end
  object dsProfesorProhibicion: TDataSource
    DataSet = TbProfesorProhibicion
    Left = 248
    Top = 328
  end
end
