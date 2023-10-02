unit Providers.Frames.Base.View;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Providers.Frames.Base, FMX.Layouts;

type
  TFrameBaseView = class(TFrameBase)
    lytContent: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
