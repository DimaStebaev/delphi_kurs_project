program kurs;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  SortedList in 'SortedList.pas',
  sv in 'sv.pas',
  normal in 'normal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
