unit FMXLabelEdit;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls, FMX.Objects, System.UITypes, FMX.Edit, System.Types, FMX.Graphics,
  FMX.StdCtrls;

type
  TLabelEdit = class(TEdit)
  private
    FLine: TLine;
    FLabel: TText;
    FErrorIcon: TPath;
    FKeyValue: string;
    FRequired: Boolean;
    FScrollMode: Boolean;
    FRecueErrorIcon: Integer;
    FFocusedColor: TAlphaColor;
    FUnFocusedColor: TAlphaColor;
    procedure CreateLine;
    procedure CreateLabel;
    procedure CreateErrorIcon;
    procedure DoOnExit(Sender: TObject);
    procedure DoOnEnter(Sender: TObject);
    procedure SetUnFocusedColor(const AValue: TAlphaColor);
    procedure DoTapScrollMode(Sender: TObject; const Point: TPointF);
    procedure DoClickScrollMode(Sender: TObject);
    procedure Validade;
  protected
    procedure Resize; override;
  public
    property KeyValue: string read FKeyValue write FKeyValue;
    constructor Create(AOwner: TComponent); override;
    function IsEmpty: Boolean;
    function IsValid: Boolean;
    procedure ActiveScrollMode;
    procedure SetValue(const AValue: string); overload;
    procedure SetValue(const AKey, AValue: string); overload;
    procedure SetValue(const AKey: Integer; const AValue: string); overload;
    procedure RecueErrorIcon(const AValue: Integer);
    procedure Focus;
    destructor Destroy; override;
  published
    property FocusedColor: TAlphaColor read FFocusedColor write FFocusedColor;
    property UnFocusedColor: TAlphaColor read FUnFocusedColor write SetUnFocusedColor;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Advanced Controls', [TLabelEdit]);
end;

procedure TLabelEdit.ActiveScrollMode;
begin
  FScrollMode := True;
  Self.CanFocus := False;
  Self.OnTap := Self.DoTapScrollMode;
  Self.OnClick := Self.DoClickScrollMode;
end;

constructor TLabelEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CreateLine;
  CreateLabel;
  Self.OnEnter := DoOnEnter;
  Self.OnExit := DoOnExit;
  FocusedColor := $FF006060;
  UnFocusedColor := $FF949494;
  FRequired := False;
  FScrollMode := False;
  FRecueErrorIcon := 0;
end;

procedure TLabelEdit.CreateErrorIcon;
begin
  FErrorIcon := TPath.Create(Self);
  FErrorIcon.SetSubComponent(True);
  FErrorIcon.Stored := False;
  FErrorIcon.Parent := Self;
  FErrorIcon.Width := 20;
  FErrorIcon.Height := 20;
  FErrorIcon.Position.Y := Self.Height - 27;
  FErrorIcon.Position.X := Self.Width - 20;
  FErrorIcon.HitTest := False;
  FErrorIcon.Visible := False;
  FErrorIcon.Stroke.Kind := TBrushKind.None;
  FErrorIcon.Position.X := FErrorIcon.Position.X - FRecueErrorIcon;
  FErrorIcon.Fill.Color := $FFDA4C4B;
  FErrorIcon.Data.Data := 'M13,13 L11,13 L11,7 L13,7 M13,17 L11,17 L11,15 L13,15 M12,2 C6.4771523475647,2 2,6.4771523475647 ' +
    '2,12 C2,17.5228481292725 6.4771523475647,22 12,22 C17.5228481292725,22 22,17.5228481292725 22,12 C22,6.4771523475647 ' +
    '17.5228481292725,2 12,2 Z';
end;

procedure TLabelEdit.CreateLabel;
begin
  FLabel := TText.Create(Self);
  FLabel.SetSubComponent(True);
  FLabel.Stored := False;
  FLabel.Parent := Self;
  FLabel.Position.X := 1;
  FLabel.Position.Y := -40;
  FLabel.TextSettings.Font.Family := Self.TextSettings.Font.Family;
  FLabel.TextSettings.Font.Size := 15;
  FLabel.TextSettings.HorzAlign := TTextAlign.Leading;
  FLabel.HitTest := False;
  FLabel.Visible := False;
end;

procedure TLabelEdit.CreateLine;
begin
  FLine := TLine.Create(Self);
  FLine.SetSubComponent(True);
  FLine.Stored := False;
  FLine.Parent := Self;
  FLine.Height := 3;
  FLine.HitTest := False;
  FLine.LineType := TLineType.Bottom;
  FLine.Align := TAlignLayout.Client;
end;

destructor TLabelEdit.Destroy;
begin
  if Assigned(FLabel) then
  begin
    FLabel.Owner.RemoveComponent(FLabel);
    FLabel.DisposeOf;
  end;

  if Assigned(FLine) then
  begin
    FLine.Owner.RemoveComponent(FLine);
    FLine.DisposeOf;
  end;

  if Assigned(FErrorIcon) then
  begin
    FErrorIcon.Owner.RemoveComponent(FErrorIcon);
    FErrorIcon.DisposeOf;
  end;

  FLabel := nil;
  FLine := nil;
  FErrorIcon := nil;
  inherited;
end;

procedure TLabelEdit.DoClickScrollMode(Sender: TObject);
begin
  Self.Focus;
end;

procedure TLabelEdit.DoOnEnter(Sender: TObject);
begin
  FLabel.Text := Self.TextPrompt;
  FLabel.Visible := True;
  FLabel.TextSettings.FontColor := FFocusedColor;
  FLine.Fill.Color := FFocusedColor;
  FLine.Stroke.Color := FFocusedColor;
  Self.TextPrompt := EmptyStr;
  if Assigned(FErrorIcon) then
    FErrorIcon.Visible := False;
end;

procedure TLabelEdit.DoOnExit(Sender: TObject);
begin
  FLabel.Visible := (not Self.Text.Trim.IsEmpty);
  Self.TextPrompt := FLabel.Text;
  FLabel.TextSettings.FontColor := FUnFocusedColor;
  FLine.Fill.Color := FUnFocusedColor;
  FLine.Stroke.Color := FUnFocusedColor;
  Validade;
  if FScrollMode then
    Self.CanFocus := False;
end;

procedure TLabelEdit.DoTapScrollMode(Sender: TObject; const Point: TPointF);
begin
  Self.Focus;
end;

procedure TLabelEdit.Focus;
begin
  Self.CanFocus := True;
  Self.SetFocus;
end;

function TLabelEdit.IsEmpty: Boolean;
begin
  Result := Self.Text.Trim.IsEmpty;
end;

procedure TLabelEdit.SetValue(const AValue: string);
begin
  Self.Text := AValue;
  FLabel.Text := Self.TextPrompt;
  if Assigned(OnTyping) then
    OnTyping(Self);
  DoOnExit(Self);
end;

procedure TLabelEdit.SetValue(const AKey, AValue: string);
begin
  FKeyValue := AKey;
  Self.SetValue(AValue);
end;

procedure TLabelEdit.SetUnFocusedColor(const AValue: TAlphaColor);
begin
  FUnFocusedColor := AValue;
  FLine.Fill.Color := AValue;
  FLine.Stroke.Color := AValue;
end;

procedure TLabelEdit.SetValue(const AKey: Integer; const AValue: string);
begin
  Self.SetValue(AKey.ToString, AValue);
end;

procedure TLabelEdit.RecueErrorIcon(const AValue: Integer);
begin
  FRecueErrorIcon := AValue;
end;

procedure TLabelEdit.Resize;
begin
  inherited;
  if (FLabel.Width <> Self.Width) then
    FLabel.Width := Self.Width;
end;

function TLabelEdit.IsValid: Boolean;
begin
  Result := not Self.IsEmpty;
  FRequired := True;
  Validade;
end;

procedure TLabelEdit.Validade;
begin
  if FRequired and Self.IsEmpty then
  begin
    FLabel.TextSettings.FontColor := $FFDA4C4B;
    FLine.Fill.Color := $FFDA4C4B;
    FLine.Stroke.Color := $FFDA4C4B;
    if not (Assigned(FErrorIcon)) then
      CreateErrorIcon;
    FErrorIcon.Visible := True;
  end
  else
  begin
    if Assigned(FErrorIcon) then
      FErrorIcon.Visible := False;
  end;
end;

end.
