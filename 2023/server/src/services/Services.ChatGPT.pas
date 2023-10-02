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
  private
    function GetObjectMessage(const AMessage: string): TJSONObject;
  public
    function GetResponseChatGPT(const AMessage: string): string;
  end;

implementation

uses
  Providers.Key, Providers.Request.Intf, Providers.Request;


{$R *.dfm}

{ TServiceChatGPT }

function TServiceChatGPT.GetObjectMessage(const AMessage: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('role', 'user').AddPair('content', AMessage);
end;

function TServiceChatGPT.GetResponseChatGPT(const AMessage: string): string;
var
  LResponse: IResponse;
  LJSONObjectMain: TJSONObject;
  LJSONArray: TJSONArray;
begin
  LJSONObjectMain := TJSONObject.Create;
  LJSONArray := TJSONArray.Create;
  LJSONObjectMain.AddPair('model', 'gpt-3.5-turbo');
  LJSONObjectMain.AddPair('messages', LJSONArray.Add(GetObjectMessage(AMessage)));

  LResponse := TRequest.New
    .BaseURL('https://api.openai.com/v1/chat/completions')
    .AddBody(LJSONObjectMain)
    .Post;
  if LResponse.StatusCode = 200 then
    Result := TJSONObject(LResponse.JSONValue).GetValue<TJSONArray>('choices').Items[0]
      .GetValue<TJSONObject>('message').GetValue<string>('content');
end;

end.
