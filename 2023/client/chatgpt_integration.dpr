program chatgpt_integration;

uses
  System.StartUpCopy,
  FMX.Forms,
  Views.Principal in 'src\views\Views.Principal.pas' {FrmPrincipal},
  Services.Base in 'src\services\Services.Base.pas' {ServiceBase: TDataModule},
  Providers.Frames.Base in 'src\providers\frames\Providers.Frames.Base.pas' {FrameBase: TFrame},
  Providers.Frames.Base.View in 'src\providers\frames\Providers.Frames.Base.View.pas' {FrameBaseView: TFrame},
  Providers.Models.Token in 'src\providers\models\Providers.Models.Token.pas',
  Providers.Request.Intf in 'src\providers\request\Providers.Request.Intf.pas',
  Providers.Request in 'src\providers\request\Providers.Request.pas',
  Providers.Singletons.Server in 'src\providers\singletons\Providers.Singletons.Server.pas',
  Providers.Session in 'src\providers\Providers.Session.pas',
  Views.AskChatGPT in 'src\views\Views.AskChatGPT.pas' {FrmAskChatGPT: TFrame},
  Services.AskChatGPT in 'src\services\Services.AskChatGPT.pas' {ServiceAskChatGPT: TDataModule},
  Providers.Aguarde.Frame in 'src\providers\aguarde\Providers.Aguarde.Frame.pas' {FrameAguarde: TFrame},
  Providers.Aguarde in 'src\providers\aguarde\Providers.Aguarde.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
