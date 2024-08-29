unit Controllers.Cliente;

interface

uses Horse, Services.Cliente, System.Classes, Horse.OctetStream;

procedure Registry;

implementation

procedure DoReportCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceCliente;
begin
  LService := TServiceCliente.Create(nil);
  try
    Res.Send<TFileReturn>(LService.GetReport(LService.frxReportBase, Req.Query.Dictionary));
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/clientes', DoReportCliente);
end;

end.
