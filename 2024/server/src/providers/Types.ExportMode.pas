unit Types.ExportMode;

interface

type
{$SCOPEDENUMS ON}
  TExportMode = (PDF, XML, CSV);
{$SCOPEDENUMS OFF}

  TExportModeHelper = record helper for TExportMode
    function GetValue: Integer;
    function GetExtension: string;
  end;

implementation

function TExportModeHelper.GetExtension: string;
begin
  case Self of
    TExportMode.PDF:
      Result := '.pdf';
    TExportMode.XML:
      Result := '.xml';
    TExportMode.CSV:
      Result := '.csv';
  end;
end;

function TExportModeHelper.GetValue: Integer;
begin
  Result := Ord(Self);
end;

end.
