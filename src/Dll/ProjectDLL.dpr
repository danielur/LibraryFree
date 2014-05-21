library ProjectDLL;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  uiPlugins in '..\Common\uiPlugins.pas';

{$R *.res}

type
  TPluginBase =class(TInterfacedObject, IPluginBase)
  protected
    procedure SetOnPluginMessage(Value: TOnStatusMessage); virtual; abstract;
  end;

  TMyPlugin = class(TPluginBase, IPluginChild)
  private
    fOnStatusMessage: TOnStatusMessage;
  protected
    procedure SetOnPluginMessage(Value: TOnStatusMessage); override;
  public
    property OnPluginMessage: TOnStatusMessage write SetOnPluginMessage;
    procedure SayHello;
  end;

function GetInterface: IPluginBase; stdcall;
begin
  Result := TMyPlugin.Create;
end;

exports
  GetInterface;

{ TMyTest }

procedure TMyPlugin.SetOnPluginMessage(Value: TOnStatusMessage);
begin
  fOnStatusMessage := Value;
end;

procedure TMyPlugin.SayHello;
begin
  if Assigned(fOnStatusMessage) then
    fOnStatusMessage('Hello');
end;

begin

end.




 