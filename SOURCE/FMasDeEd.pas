unit FMasDeEd;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FSingEdt, Db, Placemnt, Grids, DBGrids, RXCtrls, RXDBCtrl, StdCtrls,
  DBIndex, Buttons, DBCtrls, ExtCtrls, RXSplit, ImgList, ComCtrls, ToolWin;

type
  TMasterDetailEditorForm = class(TSingleEditorForm)
    DataSourceDetail: TDataSource;
    DBGridDetail: TDBGrid;
    Splitter1: TSplitter;
    procedure BtnShowClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MasterDetailEditorForm: TMasterDetailEditorForm;

implementation
uses
  QMaDeRep, Printers, FMain;
{$R *.DFM}

procedure TMasterDetailEditorForm.BtnShowClick(Sender: TObject);
begin
  PreviewMasterDetailReport(DataSource.DataSet, DataSourceDetail.DataSet,
    '', '', '', SuperTitle, Caption, poPortrait, MainForm.PrepareReport);
end;

end.

