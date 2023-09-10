unit Controllers.ChatGPT;

interface

procedure Registry;

implementation

uses Horse, DataSet.Serialize, Services.Base.Context.Horse,
  Providers.Request.Intf, System.JSON, Providers.Request, Providers.Key,
  Server.Response.Handler, Services.ChatGPT, JSON.Helpers;

procedure DoAskChatGPT(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceChatGPT;
begin
  LService := TServiceChatGPT.Create(TServiceBaseContext.New(Req));
  try
    if not(TResponseHandler.New(Res).HasError(LService.GetResponseChatGPT(TJSONObject.FromString(Req.Body))) then
      Res.Status(THTTPStatus.NoContent);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Post('/chatgpt/ask', DoAskChatGPT);
end;

end.
