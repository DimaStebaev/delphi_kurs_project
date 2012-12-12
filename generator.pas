unit generator;

interface

uses sv;

type
  TGenerator = class
  protected
    distr: TSv;
  public
    constructor Create(distribution: TSv);
    function Generate():double;virtual; abstract;
  end;

  TInvGenerator = class(TGenerator)
  public
    function Generate():double;override;
  end;

  TNeimonGenerator = class(TGenerator)
  public
    function Generate():double;override;
  end;

implementation

uses sysutils;

{ TGenerator }

constructor TGenerator.Create(distribution: TSv);
begin
randomize;
distr := distribution;
end;

{ TInvGenerator }

function TInvGenerator.Generate: double;
begin
  inherited;
  result := distr.invF(random)
end;

{ TNeimonGenerator }

function TNeimonGenerator.Generate: double;
var
x: double;
begin
repeat
x := distr.ZeroValueX + (distr.OneValueX - distr.ZeroValueX)*random;
until  distr.MaxP*random <  distr.p(x);
result := x;
end;



end.
