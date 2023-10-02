unit Services.Base;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, Providers.Singletons.Server;

type
  TServiceBase = class(TDataModule)
  end;

implementation

{$R *.dfm}

{ TServiceBase }

end.
