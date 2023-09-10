unit Server.Response;

interface

uses Server.Response.Intf, System.JSON, Data.DB;

type
  TResponse = class(TInterfacedObject, IResponse)
  private
    FErrors: TJSONArray;
    function CheckAssigned(const AObject: TObject; const AError: string = ''): IResponse;
    function CheckNotAssigned(const AObject: TObject; const AError: string = ''): IResponse;
    function CheckIsEmpty(const AValue: string; const AError: string = ''): IResponse;
    function CheckNotIsEmpty(const AValue: string; const AError: string = ''): IResponse;
    function CheckIsTrue(const ACheck: Boolean; const AError: string = ''): IResponse;
    function CheckIsFalse(const ACheck: Boolean; const AError: string = ''): IResponse;
    function SetError(const AMessage: string): IResponse; overload;
    function SetError(const AMessage: string; const AField: TField): IResponse; overload;
    function SetError(const AMessage, AFieldName: string): IResponse; overload;
    function Error: Boolean;
    function Success: Boolean;
    function GetErrors: TJSONArray;
    function GetErrorsMessage: string;
  public
    class function New: IResponse;
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils, System.StrUtils;

function TResponse.CheckAssigned(const AObject: TObject; const AError: string): IResponse;
begin
  Result := Self;
  if Assigned(AObject) then
    Result.SetError(AError);
end;

function TResponse.CheckIsFalse(const ACheck: Boolean; const AError: string): IResponse;
begin
  Result := Self;
  if not ACheck then
    Result.SetError(AError);
end;

function TResponse.CheckIsEmpty(const AValue, AError: string): IResponse;
begin
  Result := Self;
  if AValue.Trim.IsEmpty then
    Result.SetError(AError);
end;

function TResponse.CheckNotAssigned(const AObject: TObject; const AError: string): IResponse;
begin
  Result := Self;
  if not Assigned(AObject) then
    Result.SetError(AError);
end;

function TResponse.CheckNotIsEmpty(const AValue, AError: string): IResponse;
begin
  Result := Self;
  if not AValue.Trim.IsEmpty then
    Result.SetError(AError);
end;

function TResponse.CheckIsTrue(const ACheck: Boolean; const AError: string): IResponse;
begin
  Result := Self;
  if ACheck then
    Result.SetError(AError);
end;

destructor TResponse.Destroy;
begin
  if Assigned(FErrors) then
    FreeAndNil(FErrors);
  inherited;
end;

function TResponse.Error: Boolean;
begin
  Result := Assigned(FErrors) and (FErrors.Count > 0);
end;

function TResponse.SetError(const AMessage: string): IResponse;
begin
  Result := Self;
  if AMessage.Trim.IsEmpty then
    Exit;
  if not Assigned(FErrors) then
    FErrors := TJSONArray.Create;
  FErrors.AddElement(TJSONObject.Create(TJSONPair.Create('error', AMessage)));
end;

function TResponse.SetError(const AMessage: string; const AField: TField): IResponse;
begin
  Self.SetError(AMessage, AField.FieldName);
end;

function TResponse.Success: Boolean;
begin
  Result := not Self.Error;
end;

function TResponse.GetErrors: TJSONArray;
begin
  Result := FErrors;
end;

function TResponse.GetErrorsMessage: string;
var
  LError: TJSONValue;
begin
  for LError in FErrors do
  begin
    if not Result.IsEmpty then
      Result := Result + IfThen(Result.EndsWith('.'), ' ', '. ');
    Result := Result + LError.GetValue<string>('error').Trim;
  end;
end;

class function TResponse.New: IResponse;
begin
  Result := TResponse.Create;
end;

function TResponse.SetError(const AMessage, AFieldName: string): IResponse;
var
  JSONObject: TJSONObject;
begin
  Result := Self;
  if AMessage.Trim.IsEmpty or AFieldName.Trim.IsEmpty then
    Exit;
  if not Assigned(FErrors) then
    FErrors := TJSONArray.Create;
  JSONObject := TJSONObject.Create;
  JSONObject.AddPair(TJSONPair.Create('field', AFieldName));
  JSONObject.AddPair(TJSONPair.Create('error', AMessage));
  FErrors.AddElement(JSONObject);
end;

end.
