unit Types.ExportMode;

interface

type
{$SCOPEDENUMS ON}
  TTipoExportMode = (PDF, EXCEL, XML, CSV);
{$SCOPEDENUMS OFF}

  TTipoExportModeHelper = record helper for TTipoExportMode
    function GetValue: Integer;
  end;

implementation

function TTipoExportModeHelper.GetValue: Integer;
begin
  Result := Ord(Self);
end;

end.
