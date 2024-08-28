unit Services.Cliente;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Simples, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.VCLUI.Wait, frxClass,
  frxDBSet, frxExportCSV, frxExportBaseDialog, frxExportPDF, frCoreClasses;

type
  TServiceCliente = class(TServiceBaseSimples)
    qryCliente: TFDQuery;
    dbCliente: TfrxDBDataset;
  end;

implementation

{$R *.dfm}

end.
