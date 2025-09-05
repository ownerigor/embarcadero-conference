program docker_example_server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  System.SysUtils,
  Controllers.Cliente in 'src\controllers\Controllers.Cliente.pas',
  System.JSON;

const
  FPort = 9050;

procedure RegistryPing;
begin
  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LJSON: TJSONObject;
    begin
      LJSON := TJSONObject.Create;
      try
        LJSON.AddPair('status', 'ok');
        LJSON.AddPair('timestamp', DateTimeToStr(Now));
        Res.ContentType('application/json');
        Res.Send(LJSON.ToJSON);
      finally
        LJSON.Free;
      end;
    end);
end;

begin
  Controllers.Cliente.Registry;
  RegistryPing;
  THorse.Listen(FPort, '0.0.0.0',
    procedure
    begin
      Writeln(Format('Server is running on port %d', [FPort]));
    end);
end.
