program kurs;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  SortedList in 'SortedList.pas',
  sv in 'sv.pas',
  normal in 'normal.pas',
  generator in 'generator.pas',
  task in 'task.pas',
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  poisson in 'poisson.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
