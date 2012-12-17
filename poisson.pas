unit poisson;

interface

uses sv;

type
  TPoisson = class(TDiscontinuousSV)
    l: double;
    function fak(x: integer):integer;
  public
    constructor Create(l: double);
    function p(x: double):double;override;
    function GetSVValueByIndex(index: integer):double;override;
  end;

implementation

uses math;

{ TPoisson }

constructor TPoisson.Create(l: double);
begin
  inherited create;

  self.l := l;
end;

function TPoisson.fak(x: integer): integer;
var
i, res:integer;
begin
  if x<1 then result := 1
  else
  begin
    res := 1;
    for i:=1 to x do
      res := res*i;
    result := res;
  end;
end;

function TPoisson.GetSVValueByIndex(index: integer): double;
begin
  result := index;
end;

function TPoisson.p(x: double): double;
begin
  result := power(l, x)/fak(round(x))*exp(-l);
end;

end.
