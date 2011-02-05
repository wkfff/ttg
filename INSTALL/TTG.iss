; Inno Setup Script
; Created with ScriptMaker Version 1.3.12
; 4 Agosto 2000 at 18:15

[Setup]
MinVersion=4.0,4.0
AppName=Generador Automatico de Horarios
AppId=Generador Automatico de Horarios
CreateUninstallRegKey=1
UsePreviousAppDir=1
UsePreviousGroup=1
AppVersion=1.2.1
AppVerName=Generador Automatico de Horarios 1.2.1
AppCopyright=Edici�n 30-01-2011. Edison Mera. Quito-Ecuador. Madrid-Espa�a
WindowShowCaption=0
WindowStartMaximized=0
WindowVisible=0
WindowResizable=0
UninstallLogMode=Append
DirExistsWarning=0
DisableDirPage=0
DisableStartupPrompt=0
CreateAppDir=1
DisableProgramGroupPage=0
Uninstallable=1
DefaultDirName={pf}\TTG\1.2.1
DefaultGroupName=Generador Automatico de Horarios 1.2.1
LicenseFile=..\DOC\Licencia.txt
InfoAfterFile=..\DOC\Leame.txt
OutputBaseFilename=TTGSETUP
DiskSpanning=0
DiskClusterSize=512
ReserveBytes=4096
UseSetupLdr=1
SourceDir=.
OutputDir=OUTPUT

[Dirs]
Name: {app}\hlp
Name: {app}\bin
Name: {app}\demos
Name: {app}\doc

[Files]
Source: ..\bin\TTG.exe; DestDir: {app}\bin\; DestName: TTG.exe
Source: ..\hlp\TTG.CNT; DestDir: {app}\hlp\; DestName: TTG.CNT
Source: ..\hlp\TTG.hlp; DestDir: {app}\hlp\; DestName: TTG.hlp
Source: ..\doc\TTG.doc; DestDir: {app}\doc\; DestName: TTG.doc
Source: ..\demos\BritanicoInt2000.ttd; DestDir: {app}\demos\; DestName: britanic.ttd
Source: ..\demos\Salamanca1999.ttd; DestDir: {app}\demos\; DestName: salamanc.ttd
[Icons]
Name: {group}\Generador Automatico de Horarios 1.2.1; Filename: {app}\BIN\TTG.EXE; WorkingDir: {app}\BIN\; IconIndex: 0
Name: {group}\Manual del Usuario (doc); Filename: {app}\doc\TTG.doc
Name: {group}\Manual del Usuario (hlp); Filename: {app}\hlp\TTG.hlp
Name: {group}\{cm:UninstallProgram, Generador Automatico de Horarios 1.2.1}; Filename: {uninstallexe}
[INI]

[Registry]
Root: HKCU; SubKey: Software\TTG; ValueType: none; Flags: uninsdeletekey

[UninstallDelete]

[InstallDelete]

[Run]

[UninstallRun]

[Languages]
Name: default; MessagesFile: C:\Archivos de programa\Inno Setup 5\Languages\Spanish.isl
