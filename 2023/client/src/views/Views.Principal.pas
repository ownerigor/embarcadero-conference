unit Views.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts;

type
  TFrmPrincipal = class(TForm)
    StyleBook: TStyleBook;
    lytContent: TLayout;
    procedure FormActivate(Sender: TObject);
  private
    FActived: Boolean;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses Views.AskChatGPT;

procedure TFrmPrincipal.FormActivate(Sender: TObject);
var
  LFrmAskChatGPT: TFrmAskChatGPT;
begin
  if FActived then
    Exit;
  LFrmAskChatGPT := TFrmAskChatGPT.Create(lytContent);
  LFrmAskChatGPT.Align := TAlignLayout.Client;
  lytContent.AddObject(LFrmAskChatGPT);
  FActived := True;
end;

end.
