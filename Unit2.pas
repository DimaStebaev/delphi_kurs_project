unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan, sv, normal;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    EditM: TEdit;
    EditS: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    XPManifest1: TXPManifest;
    Label3: TLabel;
    EditAmount: TEdit;
    ButtonGenerate: TButton;
    GroupBox2: TGroupBox;
    CheckBoxInv: TCheckBox;
    CheckBoxNeimon: TCheckBox;
    CheckBoxProcess: TCheckBox;
    procedure EditMChange(Sender: TObject);
    procedure EditAmountChange(Sender: TObject);
    procedure ButtonGenerateClick(Sender: TObject);
  private
    ContinuousSVWithAutoInvF:TContinuousSVWithAutoInvF;
    ContinuousSV:TContinuousSV;
    Normal: TNormal;

    m, s: double;
    n: integer;

    procedure InitAsync;
    procedure Callback;
  public
    { Public declarations }
  end;

  TInicializator = class(TThread)
  protected
    procedure Execute; override;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses Unit1, task, generator, unit3;

procedure TForm2.EditMChange(Sender: TObject);
var
edit: TEdit;
x: double;
begin
edit := (sender as TEdit);
if tryStrToFloat( edit.Text, x) then edit.Color := clwhite
else edit.Color := clRed;
end;

procedure TForm2.EditAmountChange(Sender: TObject);
var
edit: TEdit;
x: integer;
begin
edit := (sender as TEdit);
if tryStrToInt( edit.Text, x) and (x>1) then edit.Color := clwhite
else edit.Color := clRed;
end;

procedure TForm2.ButtonGenerateClick(Sender: TObject);
begin
//проверка входных значений
if not tryStrToFloat(editm.Text, m) then
begin
  MessageDlg(editm.Text + ' - неподходящее значение для мат. ожидания.'+#13+
                          'Пожалуйста, введите другое значение.', mtWarning, [mbOK], 0);
  exit;
end;
if not tryStrToFloat(edits.Text, s) then
begin
  MessageDlg(edits.Text + ' - неподходящее значение для среднеквадратического отклонения.'+#13+
                          'Пожалуйста, введите другое значение.', mtWarning, [mbOK], 0);
  exit;
end;
if not (tryStrToInt(editamount.Text, n) and (n>1))  then
begin
  MessageDlg(editamount.Text + ' - неподходящее значение для объёма выборки.'+#13+
                          'Пожалуйста, введите другое значение.', mtWarning, [mbOK], 0);
  exit;
end;

InitAsync;

{
if checkboxinv.Checked then
  form1.AddTask(TTask.Create('Метод обратной функции', TInvGenerator.Create(TNormal.Create(m, s)), n));

if checkboxNeimon.Checked then
  form1.AddTask(TTask.Create('Метод Неймана', TNeimonGenerator.Create(TNormal.Create(m, s)), n));

if checkboxProcess.Checked then
  form1.AddTask(TTask.Create('Метод моделирования процесса', TNoramlProcessGenerator.Create(TNormal.Create(m, s)), n));
  }


end;

procedure TForm2.Callback;
begin
if checkboxinv.Checked then
  form1.AddTask(TTask.Create('Метод обратной функции', TInvGenerator.Create(ContinuousSVWithAutoInvF), n));

if checkboxNeimon.Checked then
  if ContinuousSV is TNormal then
    form1.AddTask(TTask.Create('Метод Неймана', TNeimonGeneratorForContinuousSV.Create(
      ContinuousSV,
      (ContinuousSV as TNormal).GetM - 7*(ContinuousSV as TNormal).GetS,
      (ContinuousSV as TNormal).GetM + 7*(ContinuousSV as TNormal).GetS,
      ContinuousSV.p((ContinuousSV as TNormal).GetM)
      ), n))
  else
    raise Exception.Create('Не заданы границы для метода Неймана');

if checkboxProcess.Checked then
  form1.AddTask(TTask.Create('Метод моделирования процесса', TNoramlProcessGenerator.Create(Normal), n));

form1.Show;
form3.Hide;
close;

end;

procedure TForm2.InitAsync;
var
init: TInicializator;
begin
hide;
form3.Show;
init := TInicializator.Create(true);
init.FreeOnTerminate := true;
init.Resume;
end;

{ TInicializator }

procedure TInicializator.Execute;
begin
if form2.CheckBoxInv.Checked then
  form2.ContinuousSVWithAutoInvF := TNormal.Create(form2.m, form2.s);
if form2.CheckBoxNeimon.Checked then
  form2.ContinuousSV := TNormal.Create(form2.m, form2.s);
if form2.CheckBoxProcess.Checked then
  form2.Normal := TNormal.Create(form2.m, form2.s);
Synchronize(form2.Callback);
end;

end.
