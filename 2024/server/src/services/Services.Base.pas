unit Services.Base;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, frxClass,
  frxDBSet, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse.OctetStream, frxExportCSV, frxExportBaseDialog,
  frxExportPDF, System.JSON, Types.ExportMode, Horse, frCoreClasses, frxExportXML, frxExportXLS;

type
  TServiceBase = class(TDataModule)
    Connection: TFDConnection;
    frxReportBase: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxCSVExport: TfrxCSVExport;
    frxXMLExport: TfrxXMLExport;
    frxXLSExport: TfrxXLSExport;
  private
    FReport: TfrxReport;
    FParams: THorseList;
    function GetExportMode: TExportMode;
    function GetReportStream: TMemoryStream;
    function PrepareReport: Boolean;
    procedure ExportReport(const AStream: TMemoryStream; const AfrxCustomExportFilter: TfrxCustomExportFilter);
  public
    function GetReport(const AReport: TfrxReport): TMemoryStream;
    function GetReportName: string; virtual;
    procedure GenerateReport(const AStream: TMemoryStream = nil);
    constructor Create(const AParams: THorseList); reintroduce;
  end;

implementation

uses
  Utils.IOUtils;

{$R *.dfm}

{ TServiceBase }

constructor TServiceBase.Create(const AParams: THorseList);
begin
  inherited Create(nil);
  FParams := AParams;
end;

procedure TServiceBase.ExportReport(const AStream: TMemoryStream; const AfrxCustomExportFilter: TfrxCustomExportFilter);
begin
  AfrxCustomExportFilter.ShowProgress := False;
  AfrxCustomExportFilter.ShowDialog := False;
  AfrxCustomExportFilter.UseFileCache := False;
  AfrxCustomExportFilter.Stream := AStream;
  FReport.PreviewPages.Export(AfrxCustomExportFilter);
end;

procedure TServiceBase.GenerateReport(const AStream: TMemoryStream);
begin
  try
    if not PrepareReport then
      Exit;
    case GetExportMode of
      TExportMode.PDF:
        ExportReport(AStream, frxPDFExport);
      TExportMode.XML:
        ExportReport(AStream, frxXMLExport);
      TExportMode.CSV:
        ExportReport(AStream, frxCSVExport);
      else
        raise Exception.Create('Export mode not implemented on GenerateReport function (Providers.Connection)');
    end;
  except
    on E: Exception do
    raise;
  end;
end;

function TServiceBase.GetExportMode: TExportMode;
var
  LExport: string;
begin
  Result := TExportMode.PDF;
  if FParams.TryGetValue('export', LExport) then
    Result := TExportMode(StrToIntDef(LExport, TExportMode.PDF.GetValue));
end;

function TServiceBase.GetReport(const AReport: TfrxReport): TMemoryStream;
begin
  FReport := AReport;
  Result := GetReportStream;
end;

function TServiceBase.GetReportName: string;
begin
  Result := 'report' + GetExportMode.GetExtension;
end;

function TServiceBase.GetReportStream: TMemoryStream;
begin
  Result := TMemoryStream.Create;
  try
     GenerateReport(Result);
  except
    Result.Free;
    raise;
  end;
end;

function TServiceBase.PrepareReport: Boolean;
begin
  Result := True;
  FReport.ShowProgress := False;
  FReport.EngineOptions.EnableThreadSafe := True;
  FReport.EngineOptions.NewSilentMode := TfrxSilentMode.simSilent;
  FReport.EngineOptions.DestroyForms := False;
  FReport.EngineOptions.UseGlobalDataSetList := False;
  FReport.EngineOptions.UseFileCache := False;
  FReport.PreviewOptions.PictureCacheInFile := False;
  FReport.PreviewOptions.PagesInCache := 0;
  FReport.PreviewOptions.AllowEdit := False;
  FReport.PrintOptions.ShowDialog := False;
  FReport.PrepareReport;
  if (FReport.Errors.Count > 0) then
    raise Exception.Create('Erros no prepare do relatório. ' + FReport.Errors.Text);
end;

end.
