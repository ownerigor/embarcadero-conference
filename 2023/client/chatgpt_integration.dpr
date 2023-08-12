program chatgpt_integration;

uses
  System.StartUpCopy,
  FMX.Forms,
  Views.Principal in 'src\views\Views.Principal.pas' {FrmPrincipal},
  Services.Base in 'src\services\Services.Base.pas' {ServiceBase: TDataModule},
  Providers.Singletons.Server in 'src\providers\singletons\Providers.Singletons.Server.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
