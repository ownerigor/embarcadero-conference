unit Controllers.ChatGPT;

interface

procedure Registry;

implementation

uses Horse, DataSet.Serialize, Services.Base.Context.Horse,
  Providers.Request.Intf, System.JSON, Providers.Request, Providers.Key,
  Services.ChatGPT, JSON.Helpers, Server.Response.Handler;

procedure DoAskChatGPT(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceChatGPT;
begin
  LService := TServiceChatGPT.Create(TServiceBaseContext.New(Req));
  try
    if Req.Query.ContainsKey('message') then
      Res.ContentType('application/json; charset=utf-8').
        Send(LService.GetResponseChatGPT(Req.Query.Field('message').AsString));
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Post('/chatgpt/ask', DoAskChatGPT);
end;

end.
