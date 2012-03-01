{ -*- mode: Delphi -*- }
unit FTheme;

{$I ttg.inc}

interface

uses
  {$IFDEF FPC}LResources{$ELSE}Windows{$ENDIF}, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, Db, Grids, Buttons, DBCtrls, Variants, ExtCtrls,
  ComCtrls, Printers, ActnList, StdCtrls, DBGrids, FMasterDetailEditor,
  FCrossManytoManyEditorR;

type

  { TThemeForm }

  TThemeForm	= class(TMasterDetailEditorForm)
    DbGParticipants: TDBGrid;
    GroupBox3: TGroupBox;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    procedure ActFindExecute(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure DataSourceStateChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FSuperTitle: string;
    {function GetCurrentLoad: Integer;}
  public
    { Public declarations }
  end;

var
  ThemeForm: TThemeForm;

implementation

uses
  DMaster, FConfig, DSource, FEditor, UTTGDBUtils, UTTGConsts;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TThemeForm.DataSourceStateChange(Sender: TObject);
begin
  inherited;
end;

procedure TThemeForm.DBGridDblClick(Sender: TObject);
begin
  inherited;
end;

procedure TThemeForm.ActFindExecute(Sender: TObject);
begin
  inherited;
end;

procedure TThemeForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
end;

procedure TThemeForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  inherited;
end;

procedure TThemeForm.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  {Caption := FSuperTitle + Format(' - %s: %d', [SLoad, GetCurrentLoad]);}
end;

procedure TThemeForm.FormActivate(Sender: TObject);
begin
  SourceDataModule.TbTheme.Locate('IdTheme', (Sender as TCustomForm).Tag, []);
end;

{
function TThemeForm.GetCurrentLoad: Integer;
var
  VBookmark: TBookmark;
  FieldComposition: TField;
begin
  Result := 0;
  with SourceDataModule, TbTheme do
  begin
    VBookmark := GetBookmark;
    DisableControls;
    try
      First;
      FieldComposition := FindField('Composition');
      while not Eof do
      begin
        Inc(Result, CompositionToDuration(FieldComposition.AsString));
        Next;
      end;
    finally
      GotoBookmark(VBookmark);
      EnableControls;
    end;
  end;
end;
}

procedure TThemeForm.FormCreate(Sender: TObject);
begin
  inherited;
  with SourceDataModule do
  begin
    FSuperTitle := Description[TbTheme];
    TbFillRequirement.MasterFields := 'IdTheme';
    TbFillRequirement.LinkedFields := 'IdTheme';
    TbFillRequirement.MasterSource := DSTheme;
    TbActivity.MasterFields := 'IdTheme';
    TbActivity.LinkedFields := 'IdTheme';
    TbActivity.MasterSource := DSTheme;
    TbParticipant.MasterFields := 'IdActivity';
    TbParticipant.LinkedFields := 'IdActivity';
    TbParticipant.MasterSource := DSActivity;
  end;
end;

procedure TThemeForm.FormDestroy(Sender: TObject);
begin
  inherited;
  SourceDataModule.TbFillRequirement.MasterSource := nil;
  SourceDataModule.TbParticipant.MasterSource := nil;
  SourceDataModule.TbActivity.MasterSource := nil;
end;

initialization

{$IFDEF FPC}
  {$i FTheme.lrs}
{$ENDIF}

end.
