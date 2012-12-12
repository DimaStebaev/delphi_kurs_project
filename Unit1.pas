unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, Gauges, TeEngine, Series, ExtCtrls, TeeProcs, Chart,
  Menus, sortedlist, StdCtrls;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Chart1: TChart;
    Series1: TBarSeries;
    Series2: TBarSeries;
    Gauge1: TGauge;
    XPManifest1: TXPManifest;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
list: TSortedList;
i : TSortedListIterator;
begin
list := TSortedList.Create;
list.Add(3);
list.Add(1);
list.Add(2);
i := list.Iterator;
if i<>nil then
  while not i.end_ do
  begin
    showmessage(floattostr(i.Value));
    i.Next;
  end;

end;

end.
