unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, Gauges, TeEngine, Series, ExtCtrls, TeeProcs, Chart,
  Menus, sortedlist, StdCtrls, generator, normal;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Chart1: TChart;
    Series1: TBarSeries;
    Gauge1: TGauge;
    XPManifest1: TXPManifest;
    Button1: TButton;
    Chart2: TChart;
    Series2: TLineSeries;
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

uses math;

procedure TForm1.Button1Click(Sender: TObject);
{var
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
end;}
var
g: TGenerator;
d: TNormal;
i: integer;
l: TSortedList;
sum: integer;
m, disp: double;
iter: TSortedListIterator;
mas: array[0..100] of double;
begin
d := TNormal.Create(0, 1);
//g := TInvGenerator.Create(d);
//g := TNeimonGenerator.Create(d);
g := TNoramlProcessGenerator.Create(d);
l := TSortedList.Create;
chart1.Series[0].Clear;
for i:=0 to 100 do
begin
  //showmessage(floattostr(g.Generate));
  mas[i] := g.Generate;
  l.Add(mas[i]);
end;

m := 0;
for i:=0 to 100 do
  m := m + mas[i];
m := m / 101;
showmessage('Матожидание: '+floattostr(m));

disp := 0;
for i:=0 to 100 do
  disp := disp + power(mas[i] - m, 2);
disp := disp / 101;
showmessage('Дисперсия: '+floattostr(disp));

iter := l.Iterator;
for i:=-10 to 10 do
begin
  sum := 0;
  while not iter.end_  and (iter.Value < i) do
  begin
    inc(sum);
    iter.Next;
  end;
  chart1.Series[0].AddXY(i, sum);
end;

iter.Destroy;
g.Destroy;
d.Destroy;
l.Destroy;
end;

end.
