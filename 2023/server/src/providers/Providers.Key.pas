unit Providers.Key;

interface

type
  TKeyAuthentication = class
  private
    FKeyAuthentication: string;
    property Key: string read FKeyAuthentication;
  public
    function GetKey: string;
    class function New: TKeyAuthentication;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, Providers.Request, System.JSON;

const
  FKey = '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';

{ TKeyAuthentication }

destructor TKeyAuthentication.Destroy;
begin

  inherited;
end;

function TKeyAuthentication.GetKey: string;
begin
  if not (FKey.IsEmpty) then
    Result := FKey
  else
    Result := 'undefined';
end;

class function TKeyAuthentication.New: TKeyAuthentication;
begin
  Result := TKeyAuthentication.Create;
end;

end.
