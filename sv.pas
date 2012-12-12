unit sv;

interface

uses SortedList, classes;

type
  TPairDouble = class
  private
    key, value: double;
  public
    constructor Create(key, value: double); 
  end;

  TSV = class
  private
    list: Tlist;
    p_max, x_min, x_max: double;
  protected
    procedure InitializeInvF(ZeroValueX, OneValueX: double);
  public
    constructor Create;virtual;
    destructor Destroy;override;
    function invF(x: double):double;virtual;
    function p(x: double):double;virtual;abstract;
    function MaxP:double;
    function ZeroValueX: double;
    function OneValueX: double;
  end;

implementation

uses sysutils;

{ TSV }

constructor TSV.Create;
begin
list := Tlist.Create;
end;

destructor TSV.Destroy;
begin
list.Clear;
list.Destroy;
inherited Destroy;
end;

procedure TSV.InitializeInvF(ZeroValueX, OneValueX: double);
var
x, dx, sum, tmp: double;
i, n: integer;
begin
  p_max := 0;
  x_min := ZeroValueX;
  x_max := OneValueX;
  sum := 0;
  n := 1000000;
  dx := (OneValueX - ZeroValueX) / n;
  for i:=0 to n-1 do
  begin
    x := ZeroValueX + dx*i;
    tmp := p(x);
    if tmp > p_max then p_max := tmp;
    sum := sum + tmp;
    list.Add(TPairDouble.Create(x, sum*dx));
  end;

end;

function TSV.invF(x: double): double;
var
l, r, t: integer;
p: TPairDouble;
begin
if (x<0) or (x>1) then raise Exception.Create('Недопустимый аргумент обратной функции');
l := 0;
r := list.Count - 1;
while l <> r do
begin
  t := (r + l) div 2;
  p := list[t];
  if p.value < x then
  begin
    if t <> l then l := t else inc(l)
  end
  else
  begin
    if t <> r then r := t
    else dec(r);
  end;
end;
p := list[l];
result := p.key;
end;

{ PairDouble }

constructor TPairDouble.Create(key, value: double);
begin
self.key := key;
self.value := value;
end;

function TSV.MaxP: double;
begin
result:= p_max;
end;

function TSV.OneValueX: double;
begin
result := x_min;
end;

function TSV.ZeroValueX: double;
begin
result := x_max;
end;

end.
