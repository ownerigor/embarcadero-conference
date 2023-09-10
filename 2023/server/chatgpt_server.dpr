program chatgpt_server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Providers.Key in 'src\providers\Providers.Key.pas',
  Controllers.ChatGPT in 'src\controllers\Controllers.ChatGPT.pas',
  Providers.Request.Intf in 'src\providers\request\Providers.Request.Intf.pas',
  Providers.Request in 'src\providers\request\Providers.Request.pas',
  Providers.Session in 'src\providers\Providers.Session.pas',
  Providers.Models.Token in 'src\providers\models\Providers.Models.Token.pas',
  Services.Base.Context.Horse in 'src\services\base\Services.Base.Context.Horse.pas',
  Services.Base.Context in 'src\services\base\Services.Base.Context.pas',
  Server.Response.Handler.Intf in 'src\providers\handler\Server.Response.Handler.Intf.pas',
  Server.Response.Handler in 'src\providers\handler\Server.Response.Handler.pas',
  Server.Response.Intf in 'src\providers\handler\Server.Response.Intf.pas',
  Server.Response in 'src\providers\handler\Server.Response.pas',
  Providers.Connection in 'src\services\base\Providers.Connection.pas' {ProviderConnection: TDataModule},
  Services.Base in 'src\services\base\Services.Base.pas' {ServiceBase: TDataModule},
  Services.ChatGPT in 'src\services\Services.ChatGPT.pas' {ServiceChatGPT: TDataModule},
  JSON.Helpers in 'src\providers\helpers\JSON.Helpers.pas',
  Arrays.Helpers in 'src\providers\helpers\Arrays.Helpers.pas';

begin
  THorse.Listen(9000);
end.
