unit normal;

interface

uses SV, generator;

type
  TNormal = class(TSV)
  private
    m, s: double;
  public
    constructor Create(m, s: double);
    function p(x: double):double;override;
  end;

  TNoramlProcessGenerator = class(TGenerator)
  public
    constructor Create(normal: TNormal);
    function Generate:double;override;
  end;

implementation

uses math;

{ TNormal }

constructor TNormal.Create(m, s: double);
begin
inherited Create;
self.m := m;
self.s := s;
self.InitializeInvF(m - 10*s, m+ 10*s);
end;

function TNormal.p(x: double): double;
begin
  result := exp(-power(x - m, 2)/(2*power(s, 2)))/(s*sqrt(2*pi));
end;

{ TNoramlProcessGenerator }

constructor TNoramlProcessGenerator.Create(normal: TNormal);
begin
  inherited Create(normal);
end;

function TNoramlProcessGenerator.Generate: double;
var
i, n: integer;
sum, a,b: double;
begin
n := 1000;
sum:=0;
a := (distr as TNormal).m/n - (distr as TNormal).s*sqrt(3/n);
b := (distr as TNormal).m/n + (distr as TNormal).s*sqrt(3/n);
for i:=0 to n-1 do
  sum := sum + a + (b-a)*random;

result := sum;
end;

end.
