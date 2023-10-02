unit Services.AskChatGPT;

interface

uses
  System.SysUtils, System.Classes, Services.Base, Providers.Request, System.JSON, Providers.Singletons.Server, System.IOUtils;

type
  TServiceAskChatGPT = class(TServiceBase)
  public
    function SendMessage(const AMessage: string): string;
  end;

implementation

{$R *.dfm}

{ TServiceAskChatGPT }

function TServiceAskChatGPT.SendMessage(const AMessage: string): string;
var
  LResponse: IResponse;
begin
  if AMessage.IsEmpty then
    raise Exception.Create('Mensagem não encontrada! Tente novamente.');
  LResponse := TRequest.New
    .BaseURL('http://localhost:9000')
    .ContentType('application/json; charset=utf-8')
    .Resource('chatgpt/ask')
    .AddParam('message', AMessage)
    .Post;
  if (LResponse.StatusCode <> 200) then
    raise Exception.Create(LResponse.Content);
  Result := LResponse.Content;
end;

end.
