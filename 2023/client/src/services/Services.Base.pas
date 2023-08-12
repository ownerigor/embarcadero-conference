unit Services.Base;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Comp.Client, Providers.Singletons.Server;

type
  TServiceBase = class(TDataModule)
  private
    function GetServer: TServer;
  end;

implementation

{$R *.dfm}

{ TServiceBase }

function TServiceBase.GetServer: TServer;
begin
  Result := TServer.GetInstance;
end;

end.
