unit task;

interface

uses classes, generator, syncobjs;

type
  ReadyCallback = procedure;

  TProcess = class;

  TTask = class
  private
    Fvalue: array  of double;
    fready: boolean;
    Fprogress: double;
    criticalsection, CanTerminate: TCriticalSection;
    thread: TProcess;
    fname: string;
    procedure qSort(var A: array of double; min, max: Integer);
  protected
    procedure setReady(ready: boolean);
    procedure setProgress(progress: double);
    procedure setValue(index: integer; value: double);
  public
    onReady: ReadyCallback;
    constructor Create(name: string; generator: TGenerator; Amount: integer);
    constructor CreateReady(name: string; mas: array of double);
    destructor Destroy; override;
    function isReady: boolean;
    function Progress:double;
    function Value(index: integer):double;
    function GetLength: integer;
    function GetName:string;
    function Mean:double;
    function Variance:double;
    function SaveToFile(filename: string):boolean;
    class function CreateFromFile(filename: string):TTask;
  end;

  TProcess = class(TThread)
  private
    generator: TGenerator;
    amount: integer;
    owner: TTask;
  protected
    constructor Create(generator: TGenerator; Amount: integer; owner: TTask);
    destructor Destroy;override;
    procedure Execute; override;
  end;

implementation

uses math, SysUtils;

{ TTask }

constructor TTask.Create(name: string; generator: TGenerator; Amount: integer);
begin
fname := name;
criticalsection := TCriticalSection.Create;
CanTerminate := TCriticalSection.Create;
fready := false;
fprogress := 0;
SetLength(fvalue, Amount);
thread := TProcess.Create(generator, amount, self);
end;

constructor TTask.CreateReady(name: string; mas: array of double);
var
i: integer;
begin
fname := name;
criticalsection := TCriticalSection.Create;
CanTerminate := TCriticalSection.Create;

SetLength(fvalue, length(mas));
for i:=0 to length(mas)-1 do
  fvalue[i] := mas[i];

fready := true;
fprogress := 1;
end;

destructor TTask.Destroy;
begin
if not isReady then thread.Terminate;

CanTerminate.Enter;
CanTerminate.Leave;

CriticalSection.Destroy;
CanTerminate.Destroy;
SetLength(fvalue, 0);
inherited;
end;

procedure TTask.qSort(var A: array of double; min, max: Integer);
var
i, j: Integer;
supp, tmp: double;
begin
supp:=A[max-((max-min) div 2)];
i:=min; j:=max;
while i<j do
  begin
    while A[i]<supp do i:=i+1;
    while A[j]>supp do j:=j-1;
    if i<=j then
      begin
        tmp:=A[i];
        A[i]:=A[j];
        A[j]:=tmp;
        i:=i+1; j:=j-1;
      end;
  end;
if min<j then qSort(A, min, j);
if i<max then qSort(A, i, max);
end;

function TTask.isReady: boolean;
begin
CriticalSection.Enter;
result:=fready;
CriticalSection.Leave;
end;

function TTask.Progress: double;
begin
CriticalSection.Enter;
result:=FProgress;
CriticalSection.Leave;
end;

procedure TTask.setProgress(progress: double);
begin
CriticalSection.Enter;
FProgress:=progress;
CriticalSection.Leave;
end;

procedure TTask.setReady(ready: boolean);
begin
CriticalSection.Enter;
if ready then qSort(fvalue, 0, high(fvalue));
fready:=ready;
CriticalSection.Leave;
if ready and (@onReady <> nil) then onReady();
end;

procedure TTask.setValue(index: integer; value: double);
begin
CriticalSection.Enter;
fvalue[index]:=value;
CriticalSection.Leave;
end;

function TTask.Value(index: integer): double;
begin
CriticalSection.Enter;
result:= fvalue[index];
CriticalSection.Leave;
end;

function TTask.GetLength: integer;
begin
CriticalSection.Enter;
result:= length(fvalue);
CriticalSection.Leave;
end;

function TTask.GetName: string;
begin
  result := fname;
end;

function TTask.Mean: double;
var
sum: double;
i: integer;
begin
  sum := 0;
  for i:=0 to self.GetLength - 1 do
    sum := sum + Value(i);
  result := sum / self.GetLength;
end;

function TTask.Variance: double;
var
i, n: integer;
sum: double;
begin
  n := self.GetLength;
  sum := 0;
  for i:=0 to n-1 do
    sum := sum + power(value(i), 2);

  result := n/(n-1)*( sum/n - power(Mean, 2) );
end;

function TTask.SaveToFile(filename: string): boolean;
var
f: textfile;
i: integer;
begin

if not isReady then
begin
  result := false;
  exit;
end;

try
  AssignFile(f, filename);
  rewrite(f);
  writeln(f, GetName);
  writeln(f, GetLength);
  for i:=0 to GetLength-1 do
    writeln(f, Value(i));

  closefile(f);
  result := true;
except
  result := false;
end;
//
end;



class function TTask.CreateFromFile(filename: string): TTask;
var
f: textfile;
name: string;
i, len: integer;
mas: array of double;
begin
assignfile(f, filename);
try
  reset(f);

  readln(f, name);
  readln(f, len);
  if len < 0 then raise Exception.Create('bad length');

  SetLength(mas, len);
  for i:=0 to len -1 do
    readln(f, mas[i]);

  result := TTask.CreateReady(name, mas);
  closefile(f);
except
  result := nil;
end

end;

{ TProcess }

constructor TProcess.Create(generator: TGenerator; Amount: integer; owner: TTask);
begin
  inherited Create(false);
  FreeOnTerminate := true;
  self.generator := generator;
  self.amount := amount;
  self.owner := owner;
end;

destructor TProcess.Destroy;
begin
  generator.Destroy;
  inherited;
end;

procedure TProcess.Execute;
var
i: integer;
begin
owner.CanTerminate.Enter;
for i:=0 to amount-1 do
begin
  owner.setValue(i, generator.Generate);
  if self.Terminated then break;
  owner.setProgress(i / (amount - 1));
end;
if not self.Terminated then
  owner.setReady(true);
owner.CanTerminate.Leave;
end;

end.
