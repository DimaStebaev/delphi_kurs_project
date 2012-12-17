unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, Gauges, TeEngine, Series, ExtCtrls, TeeProcs, Chart,
  Menus, sortedlist, StdCtrls, generator, normal, Grids, task;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Chart: TChart;
    Series1: TBarSeries;
    Gauge: TGauge;
    XPManifest1: TXPManifest;
    ButtonCancel: TButton;
    N1: TMenuItem;
    N2: TMenuItem;
    grid: TStringGrid;
    Panel: TPanel;
    Timer1: TTimer;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    PopupMenuChart: TPopupMenu;
    N2D1: TMenuItem;
    N3D1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    Button1: TButton;
    procedure ButtonCancelClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure UpdateHandler(var Message: TMessage); message WM_USER;
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N2D1Click(Sender: TObject);
    procedure N3D1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    tasks: TList;
    DrawedTaskIndex: integer;
    procedure DeleteTask(index: integer);
  protected
    procedure DrawTask(task: TTask);
    procedure DrawChart;
    procedure Visualize;
  public
    procedure AddTask(task: TTask);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses math, unit2, shellapi,
sv, poisson;

procedure VisualizeProcedure;
begin
  //form1.Visualize;
  sendmessage(form1.Handle, WM_USER, 0, 0);
end;

procedure TForm1.ButtonCancelClick(Sender: TObject);
begin
DeleteTask(DrawedTaskIndex);
end;

procedure TForm1.DrawTask(task: TTask);
var
tail, dx: double;
n, l, r, amount, i, j, counter: integer;
begin

panel.Visible := not task.isReady;
chart.Visible := task.isReady;

if task.isReady then
begin
  timer1.Enabled := false;

  tail := 0.001;
  n := task.GetLength;
  l := 0;
  r := n-1;
  amount := chart.Tag;
  while l/n < tail do inc(l);
  while (r/n > 1 - tail) and (r>l) do dec(r);
  dx := (task.Value(r) - task.Value(l))/amount;

  chart.Series[0].Clear;
  j := l;
  for i:=0 to amount -1 do
  begin
    counter := 0;
    while (j<=r) and ( task.Value(j) < task.Value(l) + dx*(i+1) ) do
    begin
      inc(counter);
      inc(j);
      //application.ProcessMessages;
    end;
    chart.Series[0].AddXY(task.Value(l) + dx*i + dx/2, counter / n);
  end;
end
else
begin
  Gauge.Visible := true;
  ButtonCancel.Visible := true;
  gauge.Progress := round( gauge.MinValue + (gauge.MaxValue - gauge.MinValue) * task.Progress);
  timer1.Enabled := true;
end;

end;

procedure TForm1.N2Click(Sender: TObject);
begin
close;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
chart.Height := ClientHeight div 2;
panel.Left := 0;
panel.Top := 0;
panel.Width := ClientWidth;
panel.Height := chart.Height;

with gauge do
begin
  width := min(panel.Width, panel.Height);
  if width > 3 then width := width - 4;
  height := width;
  top := (panel.Height - height) div 2;
  left := (panel.Width - width) div 2;
end;

buttoncancel.Left := (clientwidth - buttoncancel.Width) div 2;
buttoncancel.Top := panel.Height*2 div 3;

end;

procedure TForm1.N3Click(Sender: TObject);
begin
form2.ShowModal;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
tasks := Tlist.Create;
drawedtaskindex := -1;

grid.Cells[0,0] := '№';
grid.Cells[1,0] := 'Метод';
grid.Cells[2,0] := 'Объём выборки';
grid.Cells[3,0] := 'Оценка мат. ожидания';
grid.Cells[4,0] := 'Оценка дисперсии';

visualize;

end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
i: integer;
task: TTask;
begin
for i:=0 to tasks.Count - 1 do
begin
   task := tasks[i];
   task.Destroy;
end;
tasks.Destroy;
end;

procedure TForm1.AddTask(task: TTask);
begin
tasks.Add(task);
self.Visualize;
task.onReady :=  visualizeProcedure;
if task.isReady then visualize;
end;

procedure TForm1.Visualize;
var
i, x, y, w: integer;
MaxWidth, MaxHeight: integer;
task: TTask;
begin
//расчёт колличества строк
if tasks.Count > 0 then
  grid.RowCount := grid.FixedRows + tasks.Count
else grid.RowCount := grid.FixedRows + 1;

//заполнение значений
for i:=0 to tasks.Count - 1 do
begin
  task := tasks[i];

  grid.Cells[0, i+grid.FixedRows] := inttostr(i+1);
  grid.Cells[1, i+grid.FixedRows] := task.GetName;
  grid.Cells[2, i+grid.FixedRows] := inttostr(task.GetLength);

  if task.isReady then
  begin
    grid.Cells[3, i+grid.FixedRows] := floattostr(task.Mean);
    grid.Cells[4, i+grid.FixedRows] := floattostr(task.Variance);
  end else begin
    grid.Cells[3, i+grid.FixedRows] := 'Идёт расчёт';
    grid.Cells[4, i+grid.FixedRows] := 'Идёт расчёт';
  end

end;

//подгонка ширины столбцов
with Grid do
    begin
      MaxHeight := 0;
      for x := 0 to ColCount - 1 do
      begin
        MaxWidth := 0;
        for y := 0 to RowCount - 1 do
        begin
          w := Canvas.TextWidth(Cells[x,y]);
          if w > MaxWidth then
            MaxWidth := w;
          w := Canvas.TextHeight(Cells[x,y]);
          if w > MaxHeight then
            MaxHeight := w;
        end;
        ColWidths[x] := MaxWidth + 5;
      end;
      DefaultRowHeight := MaxHeight + 5;
      {
      w := 0;
      for x := 0 to ColCount - 2 do
        w := w + ColWidths[x];
      width := form1.ClientWidth;
      ColWidths[ColCount-1] := ClientWidth - w;
      }
    end;

//отрисовка графика
DrawChart;


end;

procedure TForm1.DrawChart;
begin
n4.Enabled := ((grid.Row - grid.FixedRows) >=0) and ((grid.Row - grid.FixedRows) < tasks.Count);

if (DrawedTaskIndex = grid.Row - grid.FixedRows) and (not timer1.Enabled)  then exit;

//отрисовка графика
if (grid.Row - grid.FixedRows >= 0) and (grid.Row - grid.FixedRows < tasks.Count) then
begin
  DrawTask(tasks[grid.row - grid.fixedrows]);
  DrawedTaskIndex := grid.row - grid.fixedrows;
end
else
begin
  //Нет задачи, график которой нужно нарисовать
  chart.Visible := false;
  Gauge.Visible := false;
  ButtonCancel.Visible := false;
  panel.Visible := true;
end;
end;

procedure TForm1.gridClick(Sender: TObject);
begin
DrawChart;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
DrawChart;
end;

procedure TForm1.DeleteTask(index: integer);
begin
if (index >=0) and (index < tasks.Count) then
begin
  TTask(tasks[index]).Destroy;
  tasks.Delete(index);
  visualize;
end;
end;

procedure TForm1.UpdateHandler(var Message: TMessage);
begin
visualize;
end;

procedure TForm1.N4Click(Sender: TObject);
var
index: integer;
sd: TSaveDialog;
begin
index := grid.Row - grid.FixedRows;
if (index <0) or (index >= tasks.Count) then
begin
  MEssageDlg('Выберите выборку для сохраниения', mtInformation, [mbOK], 0);
  exit;
end;

sd := TSaveDialog.Create(self);
sd.DefaultExt := '.vib';
sd.Filter := 'Выборка значений|*.vib';
if sd.Execute then
begin
  if not TTask(tasks[index]).SaveToFile(sd.FileName) then
    MessageDlg('Ошибка при сохранении в файл '+sd.FileName, mtError, [mbOK], 0);
end;
sd.Destroy;
end;

procedure TForm1.N5Click(Sender: TObject);
var
od: TOpenDialog;
task: TTask;
begin
od := TOpenDialog.Create(self);
od.Filter := 'Выборка значений|*.vib';
if od.Execute then
begin
  task := TTask.CreateFromFile(od.FileName);
  if task <> nil then AddTask(task)
  else
    MessageDlg('Ошибка при открытии файла', mtError, [mbOK], 0);
end;
od.Destroy;
end;

procedure TForm1.N2D1Click(Sender: TObject);
begin
chart.View3D := false;
n2d1.Checked := true;
n3d1.Checked := false;
end;

procedure TForm1.N3D1Click(Sender: TObject);
begin
chart.View3D := true;
n2d1.Checked := false;
n3d1.Checked := true;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
chart.CopyToClipboardBitmap;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
chart.CopyToClipboardMetafile(true);
end;

procedure TForm1.N10Click(Sender: TObject);
begin
ShellExecute(handle, 'open', 'help\help.html', nil, nil, SW_SHOWNORMAL);
//ShellExecute(handle,
end;

procedure TForm1.N12Click(Sender: TObject);
var
input: string;
n: integer;
begin
repeat
  input := InputBox('Количество столбцов', 'Введите количество столбцов на гистограмме.', inttostr(chart.Tag));
until tryStrToInt(input, n) and (n>0);
chart.Tag := n;
DrawedTaskIndex := -1;
DrawChart;
end;

procedure TForm1.N11Click(Sender: TObject);
var
  DLLInstance : THandle;
  About : procedure;stdcall;
begin
  @About := nil;
  DLLInstance := LoadLibrary('help\about.dll');
  if DLLInstance<>0 then
  begin
    @About := GetProcAddress(DLLInstance, 'ShowAbout');
    if @About<> nil then
      About()
    else
      MessageDlg('Ошибка при экспорте функции из библиотеки.', mtError, [mbOK], 0);
  end
  else
    MessageDlg('Не найдена библиотека about.dll.'+#13+'Повторная установка приложения решит эту проблему.', mtError, [mbOK], 0);

  FreeLibrary(DLLInstance);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
sv: TDiscontinuousSV;
g: TGenerator;
mas: array of double;
amount, n, i, j, sum: integer;
tmp, dx: double;
begin
sv := TPoisson.Create(5);
//g := TIntervalMethodGenerator.Create(sv);
g := TNeimonGeneratorForDiscontinuousSV.Create(sv, 15);
n := 10000;
SetLength(mas, n);
for i:=0 to n-1 do
  mas[i] := g.Generate;

for i:=0 to n-1 do
  for j:=i+1 to n-1 do
    if mas[i]>mas[j] then
    begin
      tmp:= mas[i];
      mas[i] := mas[j];
      mas[j] := tmp;
    end;

amount := 10;
dx := (mas[n-1]-mas[0])/amount;

chart.Series[0].Clear;
j:=0;
sum :=0;
for i:=0 to n-1 do
begin
  if mas[i] > mas[0]+dx*j then
  begin
    chart.Series[0].AddXY(mas[0]+dx*j+dx/2, sum);
    inc(j);
    sum :=0;
  end;
  inc(sum);
end;

g.Destroy;

end;

end.
