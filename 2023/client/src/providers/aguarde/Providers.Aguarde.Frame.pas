unit Providers.Aguarde.Frame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base.View, FMX.Layouts,
  FMX.Objects, FMX.Effects, FMX.Ani;

type
  TFrameAguarde = class(TFrameBaseView)
    retContent: TRectangle;
    CircleContent: TCircle;
    ShadowEffect: TShadowEffect;
    CircleLoading: TCircle;
    BitmapListAnimation: TBitmapListAnimation;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
