unit normal;

interface

uses SV;

type
  TNormal = class(TSV)
  private
    m, s: double;
  public
    constructor Create(m, s: double);
    function invF(x: double):double;override;
    function p(x: double):double;override;
  end;

implementation

uses math;

{ TNormal }

constructor TNormal.Create(m, s: double);
begin
self.m := m;
self.s := s;
end;

function TNormal.invF(x: double): double;
begin

end;

function TNormal.p(x: double): double;
begin
  result := exp(-power(x - m, 2)/(2*power(s, 2)))/(s*sqrt(2*pi));
end;

end.
