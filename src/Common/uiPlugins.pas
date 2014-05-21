unit uiPlugins;

interface

type
  TOnStatusMessage = procedure(msg: String) of object;

  IPluginBase = interface
  ['{4E24FC02-1A62-43E7-AC78-60E7EBDAD96F}']
    procedure SetOnPluginMessage(Value: TOnStatusMessage);
    property OnPluginMessage: TOnStatusMessage write SetOnPluginMessage;
  end;

  IPluginChild = interface
  ['{CBC45991-6F55-4886-AF82-014531B2705B}']
    procedure SayHello;
  end;

implementation

end.
