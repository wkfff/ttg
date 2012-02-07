{ -*- mode: Delphi -*- }
unit fconfig;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}ColorBox, LResources{$ELSE}Mask, Windows{$ENDIF}, SysUtils, Grids,
  Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ComCtrls,
  Spin, DBGrids, DSource, DMaster, DB, ExtCtrls, DBCtrls, EditBtn;

type

  { TConfigForm }

  TConfigForm = class(TForm)
    bbtOk: TBitBtn;
    cbxApplyDoubleDownHill: TCheckBox;
    creClashSubject: TEdit;
    creCrossProbability: TEdit;
    creMutationProbability: TEdit;
    creReparationProbability: TEdit;
    edBookmarks: TEdit;
    lblCrossProbability: TLabel;
    lblMutationProbability: TLabel;
    lblReparationProbability: TLabel;
    Label13: TLabel;
    Label20: TLabel;
    lblDownhillLevels: TLabel;
    lblPollinationProbability: TLabel;
    lblPopulationSize: TLabel;
    lblMaxTeacherWorkLoad: TLabel;
    pgcConfig: TPageControl;
    speMaxIteration: TSpinEdit;
    crePollinationProbability: TEdit;
    spePopulationSize: TSpinEdit;
    tbsWeigths: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    lblEmptyHours: TLabel;
    lblBrokenSubjects: TLabel;
    lblJoinedSubjects: TLabel;
    creClashTeacher: TEdit;
    creClashRoomType: TEdit;
    creEmptyHour: TEdit;
    creBrokenSession: TEdit;
    creNonScatteredSubject: TEdit;
    tbsInstitution: TTabSheet;
    Label14: TLabel;
    speMaxTeacherWorkLoad: TSpinEdit;
    memComments: TMemo;
    lblComments: TLabel;
    lblInstitutionName: TLabel;
    edtNaInstitution: TEdit;
    Label15: TLabel;
    Label18: TLabel;
    tbsOptions: TTabSheet;
    cbxRandomize: TCheckBox;
    lblSeed: TLabel;
    speSeed: TSpinEdit;
    lblResponsible: TLabel;
    edtNameResponsible: TEdit;
    lblResponsiblePosition: TLabel;
    edtPositionResponsible: TEdit;
    lblAuthority: TLabel;
    edtNameAuthority: TEdit;
    edtPositionAuthority: TEdit;
    lblAuthorityPosition: TLabel;
    Label29: TLabel;
    speNumIterations: TSpinEdit;
    lblSchoolYear: TLabel;
    edtSchoolYear: TEdit;
    lblBreakTimetableTeacher: TLabel;
    creBreakTimetableTeacher: TEdit;
    lblInitialTimetables: TLabel;
    edtInitialTimetables: TEdit;
    dbeNaSubjectRestrictionType: TDBEdit;
    dbeValSubjectRestrictionType: TDBEdit;
    lblSRName: TLabel;
    lblSRColor: TLabel;
    lblSRValue: TLabel;
    lblTRName: TLabel;
    dbeNaTeacherRestrictionType: TDBEdit;
    lblTRColor: TLabel;
    lblTRValue: TLabel;
    dbeValTeacherRestrictionType: TDBEdit;
    lblSharedDirectory: TLabel;
    dedSharedDirectory: TDirectoryEdit;
    bbtCancel: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    CBColSubjectRestrictionType: TColorBox;
    DSSubjectRestrictionType: TDataSource;
    DSTeacherRestrictionType: TDataSource;
    CBColTeacherRestrictionType: TColorBox;
    procedure cbxRandomizeClick(Sender: TObject);
    procedure DBGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DSSubjectRestrictionTypeDataChange(Sender: TObject;
      Field: TField);
    procedure CBColSubjectRestrictionTypeExit(Sender: TObject);
    procedure CBColSubjectRestrictionTypeChange(Sender: TObject);
    procedure CBColTeacherRestrictionTypeChange(Sender: TObject);
    procedure CBColTeacherRestrictionTypeExit(Sender: TObject);
    procedure DSTeacherRestrictionTypeDataChange(Sender: TObject;
      Field: TField);
    procedure bbtOkClick(Sender: TObject);
    procedure bbtCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadFromSourceDataModule;
    procedure SaveToSourceDataModule;
  end;

function ShowConfigForm(AHelpContext: THelpContext): Integer;

implementation

uses
  DSourceBase;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

function ShowConfigForm(AHelpContext: THelpContext): Integer;
var
   ConfigForm: TConfigForm;
begin
   ConfigForm := TConfigForm.Create(nil);
   with ConfigForm do
      try
         HelpContext := AHelpContext;
         LoadFromSourceDataModule;
         Result := ShowModal;
         if Result = mrOk then
	    SaveToSourceDataModule;
      finally
         Free;
      end;
end;

procedure TConfigForm.DBGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  DBGrid: TCustomDBGrid;
begin
  DBGrid := Sender as TCustomDBGrid;
  if (Copy(Column.Field.FieldName, 1, 3) = 'Col') and not Column.Field.isNull then
    Column.Color := Column.Field.AsInteger
  else
    Column.Color := clWhite;
  DBGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TConfigForm.cbxRandomizeClick(Sender: TObject);
begin
  with (Sender as TCheckbox) do
  begin
    speSeed.Enabled := not Checked;
  end;
end;

procedure TConfigForm.LoadFromSourceDataModule;
begin
   with MasterDataModule.ConfigStorage do
   begin
      edtNaInstitution.Text := NaInstitution;
      edtSchoolYear.Text := SchoolYear;
      edtNameAuthority.Text := NameAuthority;
      edtPositionAuthority.Text := PositionAuthority;
      edtNameResponsible.Text := NameResponsible;
      edtPositionResponsible.Text := PositionResponsible;
      speMaxTeacherWorkLoad.Value := MaxTeacherWorkLoad;
      memComments.Lines.Text := Comments;
      cbxRandomize.Checked := Randomize;
      speSeed.Value := Seed;
      speNumIterations.Value := RefreshInterval;
      creClashTeacher.Text := FloatToStr(ClashTeacher);
      creClashSubject.Text := FloatToStr(ClashSubject);
      creClashRoomType.Text := FloatToStr(ClashRoomType);
      creBreakTimetableTeacher.Text := FloatToStr(BreakTimetableTeacher);
      creEmptyHour.Text := FloatToStr(OutOfPositionEmptyHour);
      creBrokenSession.Text := FloatToStr(BrokenSession);
      creNonScatteredSubject.Text := FloatToStr(NonScatteredSubject);
      spePopulationSize.Value := PopulationSize;
      speMaxIteration.Value := MaxIteration;
      creCrossProbability.Text := FloatToStr(CrossProbability);
      creMutationProbability.Text := FloatToStr(MutationProbability);
      creReparationProbability.Text := FloatToStr(ReparationProbability);
      edtInitialTimetables.Text := InitialTimetables;
      dedSharedDirectory.Directory := SharedDirectory;
      crePollinationProbability.Text := FloatToStr(PollinationProbability);
      cbxApplyDoubleDownHill.Checked := ApplyDoubleDownHill;
      edBookmarks.Text := Bookmarks;
   end;
end;

procedure TConfigForm.SaveToSourceDataModule;
begin
   with MasterDataModule.ConfigStorage do
   begin
      NaInstitution := edtNaInstitution.Text;
      SchoolYear := edtSchoolYear.Text;
      NameAuthority := edtNameAuthority.Text;
      PositionAuthority := edtPositionAuthority.Text;
      NameResponsible := edtNameResponsible.Text;
      PositionResponsible := edtPositionResponsible.Text;
      MaxTeacherWorkLoad := speMaxTeacherWorkLoad.Value;
      Comments := memComments.Lines.Text;
      Randomize := cbxRandomize.Checked;
      Seed := speSeed.Value;
      RefreshInterval := speNumIterations.Value;
      ClashTeacher := StrToInt(creClashTeacher.Text);
      ClashSubject := StrToInt(creClashSubject.Text);
      ClashRoomType := StrToInt(creClashRoomType.Text);
      BreakTimetableTeacher := StrToInt(creBreakTimetableTeacher.Text);
      OutOfPositionEmptyHour := StrToInt(creEmptyHour.Text);
      BrokenSession := StrToInt(creBrokenSession.Text);
      NonScatteredSubject := StrToInt(creNonScatteredSubject.Text);
      PopulationSize := spePopulationSize.Value;
      MaxIteration := speMaxIteration.Value;
      CrossProbability := StrToFloat(creCrossProbability.Text);
      MutationProbability := StrToFloat(creMutationProbability.Text);
      ReparationProbability := StrToFloat(creReparationProbability.Text);
      InitialTimetables := edtInitialTimetables.Text;
      SharedDirectory := dedSharedDirectory.Directory;
      PollinationProbability := StrToFloat(crePollinationProbability.Text);
      ApplyDoubleDownHill := cbxApplyDoubleDownHill.Checked;
      Bookmarks := edBookmarks.Text;
   end;
end;

procedure TConfigForm.DSSubjectRestrictionTypeDataChange(Sender: TObject; Field: TField);
begin
  CBColSubjectRestrictionType.Selected :=
    SourceDataModule.TbSubjectRestrictionType.FindField('ColSubjectRestrictionType').AsInteger;
end;

procedure TConfigForm.CBColSubjectRestrictionTypeExit(Sender: TObject);
begin
  with SourceDataModule.TbSubjectRestrictionType.FindField('ColSubjectRestrictionType') do
    if (DSSubjectRestrictionType.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColSubjectRestrictionType.Selected) then
      AsInteger := CBColSubjectRestrictionType.Selected;
end;

procedure TConfigForm.bbtCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TConfigForm.bbtOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TConfigForm.CBColSubjectRestrictionTypeChange(Sender: TObject);
begin
  with DSSubjectRestrictionType do
  begin
    OnDataChange := nil;
    Edit;
    OnDataChange := DSSubjectRestrictionTypeDataChange;
  end
end;

procedure TConfigForm.CBColTeacherRestrictionTypeChange(Sender: TObject);
begin
  with DSTeacherRestrictionType do
  begin
    OnDataChange := nil;
    Edit;
    OnDataChange := DSTeacherRestrictionTypeDataChange;
  end
end;

procedure TConfigForm.CBColTeacherRestrictionTypeExit(Sender: TObject);
begin
  with SourceDataModule.TbTeacherRestrictionType.FindField('ColTeacherRestrictionType') do
    if (DSTeacherRestrictionType.State in [dsEdit, dsInsert])
        and (AsInteger <> CBColTeacherRestrictionType.Selected) then
      AsInteger := CBColTeacherRestrictionType.Selected;
end;

procedure TConfigForm.DSTeacherRestrictionTypeDataChange(
  Sender: TObject; Field: TField);
begin
  CBColTeacherRestrictionType.Selected
    := SourceDataModule.TbTeacherRestrictionType.FindField('ColTeacherRestrictionType').AsInteger;
end;

initialization
{$IFDEF FPC}
  {$i fconfig.lrs}
{$ENDIF}

end.
