unit Providers.Singletons.Server;

interface

uses System.SysUtils, System.Classes;

type
  TServer = class
  public
    function ChatGPT: string;
    class function GetInstance: TServer;
    class function NewInstance: TObject; override;
  end;

var
  Server: TServer;

implementation

{ TServer }

function TServer.ChatGPT: string;
begin
  Result := 'http://localhost:9000';
end;

class function TServer.GetInstance: TServer;
begin
  Result := TServer.Create;
end;

class function TServer.NewInstance: TObject;
begin
  if not Assigned(Server) then
    Server := TServer(inherited NewInstance);
  Result := Server;
end;

end.
