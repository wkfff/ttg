�
 THORARIOAULATIPOFORM 0�  TPF0�THorarioAulaTipoFormHorarioAulaTipoFormLeft:Top� Width�Height�OnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight �TDock97do97TopWidth� �
TToolbar97tb97ShowLeft�DockPos�  �
TToolbar97tb97NavigationVisible	 TToolbarButton97btn97MostrarLeft�Top WidthHeightHintMostrar|Mostrar el horario
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 33      33wwwwww33�����33?�??�33  �33wssw733�����33?��?�33 � �33w7sw733�����33�3?��33 �� ��33w?�w�730� ����373w77��3�����3s73s7770������7�373s370������7�3s73?� ����  w�33�ww࿿� ��w�37w?7���w�s?ss�࿿ � 3ww��w�w3��    3wwwwwws3	NumGlyphsParentShowHintShowHint	OnClickbtn97MostrarClick  TToolbarButton97	btn97NextLeft�Top WidthHeight
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 33333333333333333333333333333333333333333333333333333333333?�333333 3333333w?�33333	 333333w?�3333	� 33?��3w?�   	�� 3wwws33w?	������ ���33?w   	�� 3www3?w3333	� 33333?w33333	 333333w333333 3333333w3333333333333333333333333333333333333333333333333333	NumGlyphsOnClickbtn97NextClick  TToolbarButton97
btn97PriorLeftjTop WidthHeight
Glyph.Data
z  v  BMv      v   (                                    �  �   �� �   � � ��   ���   �  �   �� �   � � ��  ��� 33333333333333333333333333333333333333333333?�333333 333333?w�33333 �33333?w7�3333 ��3333?w37���3 ���   ?w337www �������w?�33���3 ���   3w?�7www33 ��33333w?��33333 �333333w7�333333 3333333w3333333333333333333333333333333333333333333333333333333333333333333	NumGlyphsOnClickbtn97PriorClick  TRxDBLookupCombodlcAulaTipoLeft Top Width� HeightDropDownCountDisplayEmpty(Tipo de aula)	ListStylelsDelimitedLookupFieldCodAulaTipoLookupDisplayAbrAulaTipoLookupSource
DSAulaTipoTabOrder   	TComboBoxcbVerAulaTipoLeft� Top Width� HeightHint*Ver|Qu� ver en el horario del tipo de aula
ItemHeightParentShowHintShowHint	TabOrder   �
TToolbar97tb97EditLeft�DockPos�Visible   �TPanel	pnlStatusTopaWidth�  �TPanelPanel1Width�Height>  �TDock97	do97RightLeft�Height>  �TDock97
do97BottomTopXWidth�  �TDock97do97LeftHeight>  �TRxDrawGrid
RxDrawGridWidth�Height>OptionsgoFixedVertLinegoFixedHorzLine
goVertLine
goHorzLinegoDrawFocusSelectedgoColSizing   �TFormStorageFormStorageActive	
IniSection$\Software\SGHC1\MMEd1HorarioProfesor  TRxQueryQuHorarioAulaTipoDatabaseNameSGHCSessionNameseMain_1SQL.StringsSELECT  HorarioDetalle.CodDia,  HorarioDetalle.CodHora,+  Nivel.CodNivel, ParaleloId.CodParaleloId,%  Especializacion.CodEspecializacion,  Materia.NomMateria,'  CAST(%FieldKey AS CHAR(50)) AS NombreFROM  (((((HorarioDetalleT  INNER JOIN CargaAcademica ON (HorarioDetalle.CodMateria=CargaAcademica.CodMateria)7  AND (HorarioDetalle.CodNivel=CargaAcademica.CodNivel)K  AND (HorarioDetalle.CodEspecializacion=CargaAcademica.CodEspecializacion)B  AND (HorarioDetalle.CodParaleloId=CargaAcademica.CodParaleloId))J  INNER JOIN Asignatura ON Asignatura.CodMateria=CargaAcademica.CodMateria1  AND Asignatura.CodNivel=CargaAcademica.CodNivelF  AND Asignatura.CodEspecializacion=CargaAcademica.CodEspecializacion)=  INNER JOIN Nivel ON HorarioDetalle.CodNivel=Nivel.CodNivel)e  INNER JOIN Especializacion ON HorarioDetalle.CodEspecializacion=Especializacion.CodEspecializacion)Q  INNER JOIN ParaleloId ON CargaAcademica.CodParaleloId=ParaleloId.CodParaleloId)D  INNER JOIN Materia ON CargaAcademica.CodMateria=Materia.CodMateriaWHEREQ  (Asignatura.CodAulaTipo=:CodAulaTipo)AND(HorarioDetalle.CodHorario=:CodHorario)�ORDER BY HorarioDetalle.CodDia, HorarioDetalle.CodHora, Nivel.CodNivel, ParaleloId.CodParaleloId, Especializacion.CodEspecializacion, Materia.NomMateria MacrosDataTypeftStringNameFieldKey	ParamTypeptInputValue0=0  LeftHTop0	ParamDataDataType	ftUnknownNameCodAulaTipo	ParamType	ptUnknown DataType	ftUnknownName
CodHorario	ParamType	ptUnknown    TDataSource
DSAulaTipoDataSetTbTmpAulaTipoLeftpTopX  TkbmMemTableTbTmpAulaTipoAttachedAutoRefresh	AutoIncMinValue�	FieldDefsNameCodAulaTipo
Attributes
faRequired DataType	ftInteger NameNomAulaTipo
Attributes
faRequired DataTypeftStringSize NameAbrAulaTipo
Attributes
faRequired DataTypeftStringSize
 NameCantidad
Attributes
faRequired DataType	ftInteger  EnableIndexes	AutoReposition	IndexDefsNameTbAulaTipoIndex1FieldsCodAulaTipoOptions	ixPrimaryixUnique  NameixNomAulaTipoFieldsNomAulaTipoOptionsixUniqueixCaseInsensitive  NameixAbrAulaTipoFieldsAbrAulaTipoOptionsixUniqueixCaseInsensitive   RecalcOnIndexRecalcOnFetch	SortOptions AllDataOptionsmtfSaveDatamtfSaveNonVisiblemtfSaveBlobsmtfSaveFilteredmtfSaveIgnoreRangemtfSaveIgnoreMasterDetailmtfSaveDeltas StoreDataOnFormCommaTextOptionsmtfSaveData CSVQuote"CSVFieldDelimiter,CSVRecordDelimiter,PersistentSaveOptionsmtfSaveDatamtfSaveNonVisiblemtfSaveIgnoreRangemtfSaveIgnoreMasterDetail PersistentSaveFormat
mtsfBinaryPersistentBackupProgressFlagsmtpcLoadmtpcSavemtpcCopy 	LoadLimit�EnableJournalEnableVersioningVersioningModemtvm1SinceCheckPointFilterOptions Version2.49LeftrTop0 TIntegerFieldTbTmpAulaTipoCodAulaTipoDisplayLabelOrden natural	FieldNameCodAulaTipoVisible  TStringFieldTbTmpAulaTipoNomAulaTipoDisplayLabelNombre	FieldNameNomAulaTipoRequired	Size  TStringFieldTbTmpAulaTipoAbrAulaTipoDisplayLabelAbreviatura	FieldNameAbrAulaTipoRequired	Size
  TIntegerFieldTbTmpAulaTipoCantidad	FieldNameCantidadRequired	    