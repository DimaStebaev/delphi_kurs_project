unit sv;

interface

type
  TSV = class
  protected
    procedure InitializeInvF(ZeroValueX, OneValueX: double);
  public
    function invF(x: double):double;virtual;
    function p(x: double):double;virtual;abstract;
  end;

implementation

{ TSV }

procedure TSV.InitializeInvF(ZeroValueX, OneValueX: double);
begin

end;

function TSV.invF(x: double): double;
begin

end;

end.
