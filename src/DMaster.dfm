object MasterDataModule: TMasterDataModule
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 404
  Width = 748
  object TbTmpProfesorCarga: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'CodProfesor'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Carga'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 250
    Top = 11
    object TbTmpProfesorCargaCodProfesor: TIntegerField
      DisplayLabel = 'Profesor'
      FieldName = 'CodProfesor'
    end
    object TbTmpProfesorCargaApeProfesor: TStringField
      DisplayLabel = 'Apellido'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'ApeProfesor'
      LookupDataSet = SourceDataModule.TbProfesor
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'ApeProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
      Lookup = True
    end
    object TbTmpProfesorCargaNomProfesor: TStringField
      DisplayLabel = 'Nombre'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomProfesor'
      LookupDataSet = SourceDataModule.TbProfesor
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'NomProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
      Lookup = True
    end
    object TbTmpProfesorCargaCarga: TIntegerField
      FieldName = 'Carga'
    end
  end
  object QuDistributivoProfesor: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'CodMateria'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodNivel'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodEspecializacion'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodParaleloId'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CodProfesor'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 250
    Top = 115
    object QuDistributivoProfesorCodMateria: TIntegerField
      FieldName = 'CodMateria'
      Visible = False
    end
    object QuDistributivoProfesorCodNivel: TIntegerField
      FieldName = 'CodNivel'
      Visible = False
    end
    object QuDistributivoProfesorCodEspecializacion: TIntegerField
      FieldName = 'CodEspecializacion'
    end
    object QuDistributivoProfesorCodParaleloId: TIntegerField
      FieldName = 'CodParaleloId'
      Visible = False
    end
    object QuDistributivoProfesorCodProfesor: TIntegerField
      FieldName = 'CodProfesor'
      Visible = False
    end
    object QuDistributivoProfesorNomMateria: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Materia'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'NomMateria'
      LookupKeyFields = 'CodMateria'
      LookupResultField = 'NomMateria'
      KeyFields = 'CodMateria'
      Size = 15
      Lookup = True
    end
    object QuDistributivoProfesorAbrNivel: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Nivel'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrNivel'
      LookupKeyFields = 'CodNivel'
      LookupResultField = 'AbrNivel'
      KeyFields = 'CodNivel'
      Size = 10
      Lookup = True
    end
    object QuDistributivoProfesorAbrEspecializacion: TStringField
      DisplayLabel = 'Espec.'
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'AbrEspecializacion'
      LookupKeyFields = 'CodEspecializacion'
      LookupResultField = 'AbrEspecializacion'
      KeyFields = 'CodEspecializacion'
      Required = True
      Size = 10
      Lookup = True
    end
    object QuDistributivoProfesorNomParaleloId: TStringField
      Alignment = taRightJustify
      DisplayLabel = 'Par.'
      FieldKind = fkLookup
      FieldName = 'NomParaleloId'
      LookupKeyFields = 'CodParaleloId'
      LookupResultField = 'NomParaleloId'
      KeyFields = 'CodParaleloId'
      Size = 5
      Lookup = True
    end
    object QuDistributivoProfesorApeNomProfesor: TStringField
      DisplayLabel = 'Profesor'
      DisplayWidth = 31
      FieldKind = fkLookup
      FieldName = 'ApeNomProfesor'
      LookupKeyFields = 'CodProfesor'
      LookupResultField = 'ApeNomProfesor'
      KeyFields = 'CodProfesor'
      Size = 31
      Lookup = True
    end
  end
  object QuProfesorProhibicionCant: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'CodProfesor'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Cantidad'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 58
    Top = 157
    object QuProfesorProhibicionCantCodProfesor: TIntegerField
      FieldName = 'CodProfesor'
    end
    object QuProfesorProhibicionCantCantidad: TIntegerField
      FieldName = 'Cantidad'
    end
  end
  object TbTmpAulaTipoCarga: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'CodAulaTipo'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'Carga'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '5.52'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 250
    Top = 62
    object TbTmpAulaTipoCargaCodAulaTipo: TIntegerField
      DisplayLabel = 'Tipo de aula'
      FieldName = 'CodAulaTipo'
    end
    object TbTmpAulaTipoCargaAbrAulaTipo: TStringField
      DisplayLabel = 'Nombre'
      DisplayWidth = 15
      FieldKind = fkLookup
      FieldName = 'AbrAulaTipo'
      LookupDataSet = SourceDataModule.TbAulaTipo
      LookupKeyFields = 'CodAulaTipo'
      LookupResultField = 'AbrAulaTipo'
      KeyFields = 'CodAulaTipo'
      Size = 31
      Lookup = True
    end
    object TbTmpAulaTipoCargaCarga: TIntegerField
      FieldName = 'Carga'
    end
  end
end