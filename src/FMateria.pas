unit FMateria;

{$I TTG.inc}

interface

uses
  Windows, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, FSingEdt, DB,
  Grids, Buttons, DBCtrls, ExtCtrls, Printers, ComCtrls, ToolWin, ActnList,
  FCrsMMER, ImgList, DBGrids, StdCtrls;

type
  TMateriaForm = class(TSingleEditorForm)
    BtnMateriaProhibicion: TToolButton;
    ActMateriaProhibicion: TAction;
    procedure ActMateriaProhibicionExecute(Sender: TObject);
  private
    FMateriaProhibicionForm: TCrossManyToManyEditorRForm;
    procedure FormActivate(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MateriaForm: TMateriaForm;

implementation
uses
  DMaster, FCrsMMEd, FConfig, DSource;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TMateriaForm.ActMateriaProhibicionExecute(Sender: TObject);
begin
  with SourceDataModule do
  if TCrossManyToManyEditorRForm.ToggleEditor(Self,
                                              FMateriaProhibicionForm,
					      ConfigStorage,
					      ActMateriaProhibicion) then
  with FMateriaProhibicionForm do
  begin
    with TbMateriaProhibicion do
    begin
      DisableControls;
      try
        IndexFieldNames := 'CodMateria';
        MasterFields := 'CodMateria';
        MasterSource := DSMateria;
      finally
        EnableControls;
      end
    end;
    Caption := Format('%s %s - Editando %s', [
		      SourceDataModule.NameDataSet[TbMateria],
		      TbMateriaNomMateria.Value,
		      Description[TbMateriaProhibicion]]);
    DrawGrid.Hint := Format('%s|Columnas: %s - Filas: %s ',
      [Description[TbMateriaProhibicion], Description[TbDia],
      Description[TbHora]]);
    ListBox.Hint := Format('%s|%s.  Presione <Supr> para borrar la celda',
      [Description[TbMateriaProhibicionTipo],
      Description[TbMateriaProhibicionTipo]]);
    ShowEditor(TbDia, TbHora, TbMateriaProhibicionTipo, TbMateriaProhibicion,
      TbPeriodo, 'CodDia', 'NomDia', 'CodDia', 'CodDia', 'CodHora',
      'NomHora', 'CodHora', 'CodHora', 'CodMateProhibicionTipo',
      'NomMateProhibicionTipo', 'ColMateProhibicionTipo',
      'CodMateProhibicionTipo');
    Tag := TbMateriaCodMateria.Value;
    OnActivate := FormActivate;
  end
  else
    TbMateriaProhibicion.MasterSource := nil;
end;

procedure TMateriaForm.FormActivate(Sender: TObject);
begin
  with SourceDataModule do
  begin
    TbMateria.Locate('CodMateria', (Sender as TCustomForm).Tag, []);
  end;
end;

initialization

{$IFDEF FPC}
{$i FMateria.lrs}
{$ENDIF}

end.
