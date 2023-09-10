unit Services.ChatGPT;

interface

uses
  System.SysUtils, System.Classes, Services.Base, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.Client,
  System.JSON, RESTRequest4D.Response.Contract;

type
  TServiceChatGPT = class(TServiceBase)
  public
    function GetResponseChatGPT(const AJSONObject: TJSONObject): IResponse;
  end;

implementation

uses
  RESTRequest4D, Providers.Key;


{$R *.dfm}

{ TServiceChatGPT }

function TServiceChatGPT.GetResponseChatGPT(const AJSONObject: TJSONObject): IResponse;
var
  LRequest: IRequest;
  KeyAutenthication: TKeyAuthentication;
begin
  KeyAutenthication := TKeyAuthentication.New;
  LRequest := TRequest.New
    .BaseURL('https://api.openai.com/v1/chat/completions')
    .AddHeader('Authorization: Bearer', KeyAutenthication.GetKey)
    .AddBody(AJSONObject);

end;

end.
