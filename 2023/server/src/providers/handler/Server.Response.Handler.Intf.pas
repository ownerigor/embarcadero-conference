unit Server.Response.Handler.Intf;

interface

uses Server.Response.Intf;

type
  IResponseHandler = interface
    ['{BB88B48D-539A-4032-9536-2B511B82E6C1}']
    function HasError(const AResponse: IResponse): Boolean;
  end;

implementation

end.
