unit Views.AskChatGPT;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Providers.Frames.Base.View, FMX.Layouts, FMX.Objects, FMX.Effects,
  FMX.Controls.Presentation, FMX.Edit, FMXLabelEdit, Providers.Aguarde, Services.AskChatGPT,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TFrmAskChatGPT = class(TFrameBaseView)
    retContent: TRectangle;
    retAskChatGPT: TRectangle;
    sdwAskChatGPT: TShadowEffect;
    lytLogo: TLayout;
    lytTitle: TLayout;
    lblTitle: TLabel;
    lytResponse: TLayout;
    lytMessage: TLayout;
    edtMessage: TLabelEdit;
    imgSendMessage: TPath;
    imgLogo: TPath;
    mmoResponse: TMemo;
    procedure imgSendMessageClick(Sender: TObject);
  private
    FService: TServiceAskChatGPT;
    procedure SendMessage;
    procedure ShowMessage(const AResponse: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.fmx}

{ TFrmAskChatGPT }

constructor TFrmAskChatGPT.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FService := TServiceAskChatGPT.Create(Self);
end;

destructor TFrmAskChatGPT.Destroy;
begin
  FService.Free;
  inherited;
end;

procedure TFrmAskChatGPT.imgSendMessageClick(Sender: TObject);
begin
  inherited;
  SendMessage;
end;

procedure TFrmAskChatGPT.SendMessage;
begin
  TAguarde.Aguardar(
    procedure
    begin
      TThread.Synchronize(TThread.Current,
        procedure
        begin
          ShowMessage(FService.SendMessage(edtMessage.Text));
        end);
    end);
end;

procedure TFrmAskChatGPT.ShowMessage(const AResponse: string);
begin
  mmoResponse.Lines.Add(EmptyStr);
  mmoResponse.Lines.Add(AResponse);
end;

end.
