unit Controllers.Cliente;

interface

uses Horse, Services.Cliente, System.Classes, Horse.OctetStream;

procedure Registry;

implementation

procedure DoReportCliente(Req: THorseRequest; Res: THorseResponse);
var
  LService: TServiceCliente;
begin
  LService := TServiceCliente.Create(Req.Query.Dictionary);
  try
    Res.SendFile(LService.GetReport(LService.frxReportBase), LService.GetReportName);
  finally
    LService.Free;
  end;
end;

procedure Registry;
begin
  THorse.Get('/clientes', DoReportCliente);
end;

end.
