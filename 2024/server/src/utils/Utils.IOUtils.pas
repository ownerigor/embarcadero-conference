unit Utils.IOUtils;

interface

uses System.Types, System.SysUtils, Winapi.Windows, System.JSON, System.IOUtils, EncdDecd, System.Zip,
  System.Classes, System.NetEncoding;

type
  TIOUtils = class
  private
    class var FSetupDirectory: string;
  public
    class function GetFileVersion(const AFile: string): string;
    class function GetApplicationPath: string;
    class function GetApplicationName: string;
    class function GetTempDirectory: string;
    class function GetApplicationTempDirectory(const ACreateIfNotExists: Boolean = True): string;
    class function GetSetupDirectory: string;
    class function EncodeFile(const AFileName: string): string;
    class function DecodeFile(const AFileName, ADestination: string): string;
    class procedure ZipFiles(const AFiles: TStringList; const ADestination: string);
    class procedure ZipFile(const AFileName, ADestination: string);
    class procedure UnZipFiles(const AFileName, ADestination: string);
    class procedure DeleteFilesFromFolder(const AFolder: string);
  end;

implementation

class function TIOUtils.DecodeFile(const AFileName, ADestination: string): string;
var
  LStream: TBytesStream;
begin
  Result := ADestination;
  LStream := TBytesStream.Create(DecodeBase64(AnsiString(AFileName)));
  try
    LStream.SaveToFile(ADestination);
  finally
    LStream.Free;
  end;
end;

class procedure TIOUtils.DeleteFilesFromFolder(const AFolder: string);
var
  LFiles: TStringDynArray;
  LFile: string;
begin
  LFiles := TDirectory.GetFiles(AFolder);
  for LFile in LFiles do
    DeleteFile(PWideChar(LFile));
end;

class function TIOUtils.EncodeFile(const AFileName: string): string;
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    LStream.LoadFromFile(AFileName);
    Result := string(EncodeBase64(LStream.Memory, LStream.Size));
  finally
    LStream.Free;
  end;
end;

class function TIOUtils.GetApplicationName: string;
const
  INVALID_PATH = '\\?\';
var
  LPath: array[0..MAX_PATH - 1] of Char;
begin
  SetString(Result, LPath, GetModuleFileName(HInstance, LPath, SizeOf(LPath)));
  Result := Result.Replace(INVALID_PATH, EmptyStr);
end;

class function TIOUtils.GetApplicationPath: string;
begin
  Result := ExtractFilePath(GetApplicationName);
end;

class function TIOUtils.GetApplicationTempDirectory(const ACreateIfNotExists: Boolean): string;
begin
  Result := TIOUtils.GetApplicationPath + 'temp\';
  if not DirectoryExists(Result) then
    MkDir(Result);
end;

class function TIOUtils.GetFileVersion(const AFile: string): string;
var
  Size, Handle: DWORD;
  Buffer: TBytes;
  FixedPtr: PVSFixedFileInfo;
begin
  Result := '0.0.0.0';
  if FileExists(AFile) then
  begin
    Size := GetFileVersionInfoSize(PChar(AFile), Handle);
    if Size = 0 then
      RaiseLastOSError;
    SetLength(Buffer, Size);
    if not GetFileVersionInfo(PChar(AFile), Handle, Size, Buffer) then
      RaiseLastOSError;
    if not VerQueryValue(Buffer, '\', Pointer(FixedPtr), Size) then
      RaiseLastOSError;
    Result := Format('%d.%d.%d.%d', [LongRec(FixedPtr.dwFileVersionMS).Hi, LongRec(FixedPtr.dwFileVersionMS).Lo,
      LongRec(FixedPtr.dwFileVersionLS).Hi, LongRec(FixedPtr.dwFileVersionLS).Lo]);
  end;
end;

class function TIOUtils.GetSetupDirectory: string;
begin
  if FSetupDirectory.Trim.IsEmpty then
  begin
    if ExtractFileName(GetApplicationName).ToLower.Equals('setup.exe') then
      FSetupDirectory := GetApplicationPath + 'files\setup.json'
    else
      FSetupDirectory := ExtractFilePath(ExcludeTrailingPathDelimiter(GetApplicationPath)) + 'files\setup.json';
  end;
  Result := FSetupDirectory;
end;

class function TIOUtils.GetTempDirectory: string;
var
  LTempFolder: array[0..MAX_PATH] of Char;
begin
  GetTempPath(MAX_PATH, @LTempFolder);
  Result := StrPas(LTempFolder);
end;

class procedure TIOUtils.UnZipFiles(const AFileName, ADestination: string);
var
  LZipFile: TZipFile;
begin
  LZipFile := TZipFile.Create();
  try
    LZipFile.Open(AFileName, zmRead);
    LZipFile.ExtractAll(ADestination);
    LZipFile.Close;
  finally
    LZipFile.Free;
  end;
end;

class procedure TIOUtils.ZipFile(const AFileName, ADestination: string);
var
  LFiles: TStringList;
begin
  LFiles := TStringList.Create;
  LFiles.Add(AFileName);
  ZipFiles(LFiles, ADestination);
end;

class procedure TIOUtils.ZipFiles(const AFiles: TStringList; const ADestination: string);
var
  LZipFile: TZipFile;
  LFileName: string;
begin
  LZipFile := TZipFile.Create;
  try
    LZipFile.Open(ADestination, zmWrite);
    for LFileName in AFiles do
      LZipFile.Add(LFileName);
    LZipFile.Close;
  finally
    AFiles.Free;
    LZipFile.Free;
  end;
end;

end.
