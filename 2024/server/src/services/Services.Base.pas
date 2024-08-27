unit Services.Base;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FB, FireDAC.Phys.FBDef, frxClass,
  frxDBSet, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Horse.OctetStream, frxExportCSV, frxExportBaseDialog,
  frxExportPDF, Providers.Consts, System.JSON, Types.ExportMode, Horse;

type
  TServiceBase = class(TDataModule)
    Connection: TFDConnection;
    frxReportBase: TfrxReport;
    frxPDFExport: TfrxPDFExport;
    frxCSVExport: TfrxCSVExport;
  private
    FReport: TfrxReport;
    FReportPath: string;
    FExportMode: string;
    procedure ExportReport(const AStream: TMemoryStream; const AfrxCustomExportFilter: TfrxCustomExportFilter);
    function GetExportMode(const AParams: THorseList): TfrxCustomExportFilter;
    function GetReportFilePath: string;
  public
    function GetReport(const AReport: TfrxReport; const AQuery: TFDQuery; const AParams: THorseList): TStream;
  end;

implementation

{$R *.dfm}

{ TServiceBase }

procedure TServiceBase.ExportReport(const AStream: TMemoryStream; const AfrxCustomExportFilter: TfrxCustomExportFilter);
begin
  AfrxCustomExportFilter.ShowProgress := False;
  AfrxCustomExportFilter.ShowDialog := False;
  AfrxCustomExportFilter.UseFileCache := False;
  AfrxCustomExportFilter.Stream := AStream;
  AfrxCustomExportFilter.DefaultPath := EmptyStr;
  AfrxCustomExportFilter.FileName := EmptyStr;
  FReport.PreviewPages.Export(AfrxCustomExportFilter);
  FReport.Clear;
end;

function TServiceBase.GetExportMode(const AParams: THorseList): TfrxCustomExportFilter;
begin
  Result := frxPDFExport;
  AParams.TryGetValue('export', FExportMode);
  if FExportMode.IsEmpty then
    Exit;
  if FExportMode.ToInteger = TTipoExportMode.PDF.GetValue then
    Result := frxPDFExport
  else if FExportMode.ToInteger = TTipoExportMode.EXCEL.GetValue then
    //Result := frx
  else if FExportMode.ToInteger = TTipoExportMode.CSV.GetValue then
    Result := frxCSVExport;
    //else
    //Result := xml
end;

function TServiceBase.GetReport(const AReport: TfrxReport; const AQuery: TFDQuery; const AParams: THorseList): TStream;
begin
  Result := TMemoryStream.Create;
   FReport := AReport;
  AReport.ShowProgress := False;
  AReport.EngineOptions.EnableThreadSafe := True;
  AReport.EngineOptions.SilentMode := True;
  AReport.EngineOptions.DestroyForms := False;
  AReport.EngineOptions.UseGlobalDataSetList := False;
  AReport.EngineOptions.UseFileCache := True;
  AReport.PreviewOptions.PagesInCache := 200;
  AReport.PreviewOptions.PictureCacheInFile := True;
  AReport.PreviewOptions.AllowEdit := False;
  AReport.EngineOptions.MaxMemSize := 100;
  AReport.EngineOptions.ReportThread := TThread.CurrentThread;
  AReport.PrepareReport(False);
  if (AReport.Errors.Count > 0) then
    raise Exception.Create('Erros no prepare do relatório. ' + AReport.Errors.Text);
  ExportReport(TMemoryStream(Result), GetExportMode(AParams));
end;

function TServiceBase.GetReportFilePath: string;
begin
  Result := '';
  FReportPath := Result;
end;

end.
