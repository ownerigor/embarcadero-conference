unit Providers.Singletons.Server;

interface

uses System.SysUtils, System.Classes;

type
  TServer = class
  private
    function FormatURL(const AValue: string): string;
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
  Result := '';
  //URL da minha API do ChatGPT.
end;

function TServer.FormatURL(const AValue: string): string;
begin
  Result := AValue;
  if not Result.EndsWith('/') and not Result.Trim.IsEmpty then
    Result := Result + '/';
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
