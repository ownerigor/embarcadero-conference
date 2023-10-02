unit Providers.Session;

interface

uses Providers.Models.Token;

type
  TSession = class
  private
    FToken: TToken;
    procedure Inicializar;
  public
    property Token: TToken read FToken write FToken;
    class function GetInstance: TSession;
    class function NewInstance: TObject; override;
    destructor Destroy; override;
  end;

var
  Session: TSession;

implementation

{ TSession }

destructor TSession.Destroy;
begin
  FToken.Free;
  inherited;
end;

class function TSession.GetInstance: TSession;
begin
  Result := TSession.Create;
end;

procedure TSession.Inicializar;
begin
  FToken := TToken.Create;
end;

class function TSession.NewInstance: TObject;
begin
  if not (Assigned(Session)) then
  begin
    Session := TSession(inherited NewInstance);
    Session.Inicializar;
  end;
  Result := Session;
end;

initialization

finalization
  if Assigned(Session) then
    Session.Free;

end.
