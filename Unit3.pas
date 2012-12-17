unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Gauges;

type
  TForm3 = class(TForm)
    Gauge1: TGauge;
    Timer1: TTimer;
    Label1: TLabel;
    Panel1: TPanel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Timer1Timer(Sender: TObject);
var
color: TColor;
begin
if gauge1.Progress = gauge1.MaxValue then
begin
  gauge1.Progress := 0;
  color := gauge1.ForeColor;
  gauge1.ForeColor := gauge1.BackColor;
  //gauge1.ForeColor := random(65000);
  gauge1.BackColor := color;
end;
gauge1.Progress := gauge1.Progress + 1;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
timer1.Enabled := true;
end;

procedure TForm3.FormHide(Sender: TObject);
begin
timer1.Enabled := false;
end;

end.
