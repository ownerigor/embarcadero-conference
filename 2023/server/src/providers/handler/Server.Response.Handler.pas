unit Server.Response.Handler;

interface

uses Server.Response.Handler.Intf, Server.Response.Intf, System.JSON, Horse;

type
  TResponseHandler = class(TInterfacedObject, IResponseHandler)
  private
    FResponse: THorseResponse;
    function HasError(const AResponse: IResponse): Boolean;
    constructor Create(const AResponse: THorseResponse);
  public
    class function New(const AResponse: THorseResponse): IResponseHandler;
  end;

implementation

constructor TResponseHandler.Create(const AResponse: THorseResponse);
begin
  FResponse := AResponse;
end;

function TResponseHandler.HasError(const AResponse: IResponse): Boolean;
begin
  Result := AResponse.Error;
  if Result then
    FResponse.ContentType('application/json').Status(THTTPStatus.BadRequest).Send(AResponse.GetErrors.Clone as TJSONArray);
end;

class function TResponseHandler.New(const AResponse: THorseResponse): IResponseHandler;
begin
  Result := TResponseHandler.Create(AResponse);
end;

end.
