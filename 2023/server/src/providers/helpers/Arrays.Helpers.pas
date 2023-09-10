unit Arrays.Helpers;

interface

uses System.Generics.Collections;

type
  TArrayHelper = class helper for TArray
    class function Add<T: class>(var AValues: TArray<T>; const AItem: T): TArray<T>;
    class procedure Remove<T: class>(var AValues: TArray<T>; const AIndex: Integer);
    class procedure Free<T: class>(const AValues: TArray<T>);
  end;

implementation

class function TArrayHelper.Add<T>(var AValues: TArray<T>; const AItem: T): TArray<T>;
begin
  Result := AValues;
  if not Assigned(AItem) then
    Exit;
  SetLength(AValues, Succ(Length(AValues)));
  AValues[Pred(Length(AValues))] := AItem;
end;

class procedure TArrayHelper.Free<T>(const AValues: TArray<T>);
var
  LItem: T;
begin
  for LItem in AValues do
    if Assigned(LItem) then
      LItem.Free;
end;

class procedure TArrayHelper.Remove<T>(var AValues: TArray<T>; const AIndex: Integer);
var
  I: Integer;
begin
  AValues[AIndex].Free;
  for I := AIndex to Pred(Length(AValues)) do
    AValues[I] := AValues[Succ(I)];
  SetLength(AValues, Pred(Length(AValues)));
end;

end.
