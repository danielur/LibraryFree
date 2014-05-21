program ProjectApp;

uses
  Forms,
  uiPlugins in '..\Common\uiPlugins.pas',
  ufrmMain in 'scr\ufrmMain.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
