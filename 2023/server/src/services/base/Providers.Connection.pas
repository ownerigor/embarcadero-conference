unit Providers.Connection;

interface

uses System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.IBBase, FireDAC.Comp.UI, FireDAC.ConsoleUI.Wait,
  System.JSON;

type
  TProviderConnection = class(TDataModule)
  private
    FFilePathProcesso: string;
  protected
    FIdProcesso: Int64;
  public
    property IdProcesso: Int64 read FIdProcesso;
    property FilePathProcesso: string read FFilePathProcesso;
  end;

implementation

{$R *.dfm}

end.
