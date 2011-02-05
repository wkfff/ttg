program DBUTILS;
{$APPTYPE CONSOLE}
uses
  Forms,
  SysUtils,
  Acc2Pdx in 'Acc2Pdx.pas',
  DBPack in 'DBPack.pas',
  Ac2PxUtl in 'Ac2PxUtl.pas',
  PdxUtils in 'PdxUtils.pas',
  AccUtl in 'AccUtl.pas',
  Ac2DMUtl in 'Ac2DMUtl.pas',
  Acc2DM in 'Acc2DM.pas',
  ArDBUtls in '..\..\arctl\SOURCE\ArDBUtls.pas',
  DBPacker in '..\..\arctl\SOURCE\DBPacker.pas',
  BZIP2 in '..\..\arctl\SOURCE\BZIP2.PAS',
  ARCConst in '..\..\arctl\SOURCE\ARCConst.pas',
  DAO_TLB in 'C:\Documents and Settings\edison\Mis documentos\RAD Studio\7.0\Imports\DAO_TLB.pas',
  Ac2SQUtl in 'Ac2SQUtl.pas',
  Acc2SQL in 'Acc2SQL.pas';

begin
  if ParamCount = 0 then
  begin
    WriteLn(
      'DBUTILS.  Database Utilities version 1.1'#13#10 +
      #13#10 +
      'Edition 09-13-1999/2011 by Edison Mera.'#13#10 +
      'Usage:'#13#10 +
      '  DBUTILS [OPTION [PARAMETERS]]'#13#10 +
      #13#10 +
      '  OPTION:      Selected option: /DBPACK, /DBUNPACK, /ACC2PDX, /ACC2DM, /ACC2SQL.'#13#10 +
      '  PARAMETERS:  Parameters for the option.'#13#10 +
      '  The option without parameters shows the help.'#13#10 +
      #13#10 +
      'Example:'#13#10 +
      '  DBUTILS /DBPACK C:\BASE BASE.DBP');
  end
  else
  begin
    if UpperCase(ParamStr(1)) = '/DBPACK' then
      DBPackCommand
    else if UpperCase(ParamStr(1)) = '/DBUNPACK' then
      DBUnPackCommand
    else if UpperCase(ParamStr(1)) = '/ACC2PDX' then
      AccessToParadoxCommand
    else if UpperCase(PAramStr(1)) = '/ACC2DM' then
      AccessToDataModuleCommand
    else if UpperCase(PAramStr(1)) = '/ACC2SQL' then
      AccessToSQLCommand
    else
      raise Exception.Create('Invalid option');
  end;
end.
