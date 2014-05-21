unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uiPlugins;

type
  TfrmMain = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure OnPluginMessage(msg: String);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.Button1Click(Sender: TObject);
var
  GetInterfaceProc: function: IPluginBase; stdcall;
  tempIntf: IPluginBase;
  dllHandle: THandle;
begin
  dllHandle := LoadLibrary('ProjectDll.dll') ;

  if (dllHandle <> 0) then
    @GetInterfaceProc := GetProcAddress(dllHandle, 'GetInterface');

  if Assigned(GetInterfaceProc) then
  begin
    tempIntf := GetInterfaceProc;
    tempIntf.OnPluginMessage := OnPluginMessage;

    if Supports(tempIntf, IPluginChild) then
      (tempIntf as IPluginChild).SayHello;

    tempIntf := nil;
//    FreeLibrary(dllHandle);  //access violation here
  end
  else
  begin
    ShowMessage('nie ma pliku') ;
  end;
end;

procedure TfrmMain.OnPluginMessage(msg: String);
begin
  Memo1.Lines.Add(msg);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

end.
