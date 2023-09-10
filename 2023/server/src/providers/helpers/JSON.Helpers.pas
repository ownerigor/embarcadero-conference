unit JSON.Helpers;

interface

uses System.JSON, REST.Json, Arrays.Helpers, System.Generics.Collections;

type
  TJSONObjectHelper = class helper for TJSONObject
    class function FromString(const AValue: string): TJSONObject;
    procedure UpdatePair(const APairName, APairValue: string);
  end;

  TJSONArrayHelper = class helper for TJSONArray
    class function FromString(const AValue: string): TJSONArray;
  end;

  TJsonHelper = class helper for TJson
    class function ToObject<T: class, constructor>(const AJSONObject: TJSONObject; const AOwns: Boolean = True): T; overload;
    class function ToObjectArray<T: class, constructor>(const AJSONArray: TJSONArray; const AOwns: Boolean = True): TArray<T>;
    class function ToJSON(const AObject: TObject; const AOwns: Boolean = True): TJSONObject; overload;
    class function ToJSONArray<T: class, constructor>(const AArray: TArray<T>; const AOwns: Boolean = True): TJSONArray;
    class procedure ToObject(const AObject: TObject; const AJSONObject: TJSONObject; const AOwns: Boolean = True); overload;
  end;

const
  JSON_OPTIONS: TJsonOptions = [joDateIsUTC, joDateFormatISO8601, joIgnoreEmptyStrings, joIgnoreEmptyArrays];

implementation

class function TJSONObjecthelper.FromString(const AValue: string): TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(AValue) as TJSONObject;
end;

class function TJSONArrayHelper.FromString(const AValue: string): TJSONArray;
begin
  Result := TJSONObject.ParseJSONValue(AValue) as TJSONArray;
end;

class function TJsonHelper.ToJSONArray<T>(const AArray: TArray<T>; const AOwns: Boolean = True): TJSONArray;
var
  LItem: T;
begin
  Result := TJSONArray.Create;
  for LItem in AArray do
    Result.AddElement(TJson.ToJSON(LItem, False));
  if AOwns then
    TArray.Free<T>(AArray);
end;

class procedure TJsonHelper.ToObject(const AObject: TObject; const AJSONObject: TJSONObject; const AOwns: Boolean);
begin
  TJson.JsonToObject(AObject, AJSONObject, JSON_OPTIONS);
  if AOwns then
    AJSONObject.Free;
end;

class function TJsonHelper.ToObject<T>(const AJSONObject: TJSONObject; const AOwns: Boolean = True): T;
begin
  Result := TJson.JsonToObject<T>(AJSONObject, JSON_OPTIONS);
  if AOwns then
    AJSONObject.Free;
end;

class function TJsonHelper.ToObjectArray<T>(const AJSONArray: TJSONArray; const AOwns: Boolean = True): TArray<T>;
var
  LJSONValue: TJSONValue;
begin
  Result := TArray<T>.Create();
  for LJSONValue in AJSONArray do
    TArray.Add<T>(Result, TJSON.ToObject<T>(TJSONObject(LJSONValue), False));
  if AOwns then
    AJSONArray.Free;
end;

class function TJsonHelper.ToJSON(const AObject: TObject; const AOwns: Boolean = True): TJSONObject;
begin
  Result := TJson.ObjectToJsonObject(AObject, JSON_OPTIONS);
  if AOwns then
    AObject.Free;
end;

procedure TJSONObjectHelper.UpdatePair(const APairName, APairValue: string);
begin
  Self.RemovePair(APairName).Free;
  Self.AddPair(APairName, APairValue);
end;

end.