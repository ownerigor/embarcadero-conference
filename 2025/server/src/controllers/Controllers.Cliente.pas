unit Controllers.Cliente;

interface

procedure Registry;

implementation

uses
  Horse, System.JSON, System.SysUtils, System.JSON.Utils;

procedure DoGetClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  var LJSONObject :=
    TJSONObject.Create
      .AddPair('nome', 'Igor Queirantes')
      .AddPair('idade', 22)
      .AddPair('datanascimento', '22/11/2002');
  Res.ContentType('application/json').Send(LJSONObject.ToJSON);
end;

procedure DoPostClientes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Status(201).Send('Cliente criado com sucesso');
end;

procedure DoPatchCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Status(204);
end;

procedure DoDeleteCliente(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Status(204);
end;

procedure Registry;
begin
  THorse.Get('clientes', DoGetClientes);
  THorse.Post('clientes', DoPostClientes);
  THorse.Patch('clientes/:id', DoPatchCliente);
  THorse.Delete('clientes/:id', DoDeleteCliente);
end;

end.
