program reports_server;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.OctetStream,
  Services.Base in 'src\services\Services.Base.pas' {ServiceBase: TDataModule},
  Services.Base.Simples in 'src\services\Services.Base.Simples.pas' {ServiceBaseSimples: TDataModule},
  Controllers.Cliente in 'src\controllers\Controllers.Cliente.pas',
  Services.Cliente in 'src\services\Services.Cliente.pas' {ServiceCliente: TDataModule},
  Types.ExportMode in 'src\providers\Types.ExportMode.pas',
  Utils.IOUtils in 'src\utils\Utils.IOUtils.pas';

begin
  {$IFDEF MSWINDOWS}
  IsConsole := False;
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  THorse
    .Use(OctetStream);

  Controllers.Cliente.Registry;

  THorse.Listen(9000);
  Writeln('Server is runing...');
  Readln;
end.
