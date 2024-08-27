unit Controllers.Cliente;

interface

uses Horse, Providers.Consts, Services.Cliente, System.Classes, Horse.OctetStream;

procedure Registry;

implementation

procedure DoReportCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceCliente;
begin
  LService := TServiceCliente.Create(nil);
  try
    Res.Send<TStream>(LService.GetReport(LService.frxReportBase, LService.qryCliente, Req.Query.Dictionary));
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/clientes', DoReportCliente);
end;

end.
