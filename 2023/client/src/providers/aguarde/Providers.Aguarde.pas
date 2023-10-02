unit Providers.Aguarde;

interface

uses System.SysUtils, System.Classes, Providers.Aguarde.Frame, FMX.Forms,
  FMX.Types;

type
  TAguarde = class
  public
    class procedure Aguardar(const AProc: TProc);
  end;

implementation

class procedure TAguarde.Aguardar(const AProc: TProc);
var
  LFrame: TFrameAguarde;
begin
  LFrame := TFrameAguarde.Create(Screen.ActiveForm);
  LFrame.Align := TAlignLayout.Contents;
  LFrame.Parent := Screen.ActiveForm;
  Screen.ActiveForm.AddObject(LFrame);
  LFrame.BringToFront;
  TThread.CreateAnonymousThread(
    procedure
    begin
      try
        AProc;
      finally
        TThread.Synchronize(TThread.Current,
          procedure
          begin
            LFrame.Owner.RemoveComponent(LFrame);
            LFrame.DisposeOf;
          end);
      end;
    end).Start;
end;

end.
