unit generator;

{
���� ������ �������� �������� ����������� �������,
������� ��������� ���������� �������� ��������� �������.
}

interface

uses sv;

type
  //�����, ������������ �������� ��������� ��������
  TGenerator = class
  protected
    distr: TSv;
    //��������� ��������
  public
    constructor Create(distribution: TSv);
    //distribution - �����, ����������� ��������� ��������

    destructor Destroy;

    function Generate():double;virtual;abstract;
    //�����, ������������ �������� ��������� ��������
  end;

{����������� ��������� ��������}

  //���������, ���������� �� ������ �������� �������
  TInvGenerator = class(TGenerator)
  public
    constructor Create(distribution: TContinuousSVWithInvF);
    //distribution - ��������� �������� � �������� �������� �������� ������� �������������

    function Generate():double;override;
    //�����, ������������ �������� ��������� ��������
  end;

//���������, ���������� �� ������ ������� ��� ����������� ��������� ��������
  TNeimonGeneratorForContinuousSV = class(TGenerator)
  private
    left, right, maxValue: double;
  public
    constructor Create(distribution: TContinuousSV; left, right, MaxValue: double);
    //distribution - ����������� ��������� ��������
    //left, right - ����������, � ������� �������� ����� �������.
    //����������� �������� �� left �� right �� ������� ��������� ����������� ������� ���� ����� ��� ���������� � �������
    //MaxValue - �����, ������� �� ������, ��� ���������� �������� ������� ��������� �����������.

    function Generate():double;override;
    //�����, ������������ �������� ��������� ��������
  end;

{���������� ��������� ��������}

  TIntervalMethodGenerator = class(TGenerator)
  public
    constructor Create(distribution: TDiscontinuousSV);
    function Generate():double;override;
  end;

  TNeimonGeneratorForDiscontinuousSV = class(TGenerator)
  private
    maxI: integer;
  public
    constructor Create(distribution: TDiscontinuousSV; maxIndex: integer);
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

destructor TGenerator.Destroy;
begin
  distr.Destroy;
  inherited;
end;

{ TInvGenerator }

constructor TInvGenerator.Create(distribution: TContinuousSVWithInvF);
begin
  inherited Create(distribution);
end;

function TInvGenerator.Generate: double;
begin
  inherited;
  result := TContinuousSVWithInvF(distr).invF(random)
end;

{ TNeimonGenerator }

constructor TNeimonGeneratorForContinuousSV.Create(
  distribution: TContinuousSV; left, right, MaxValue: double);
begin
inherited Create(distribution);
self.left := left;
self.right := right;
self.maxValue := maxValue;
end;

function TNeimonGeneratorForContinuousSV.Generate: double;
var
x: double;
begin
repeat
x := left + (right - left)*random;
until  MaxValue*random <  TContinuousSV(distr).p(x);
result := x;
end;



{ TIntervalMethodGenerator }

constructor TIntervalMethodGenerator.Create(
  distribution: TDiscontinuousSV);
begin
  inherited Create(distribution);
end;

function TIntervalMethodGenerator.Generate: double;
var
r, x: double;
i: integer;
sv: TDiscontinuousSV;
begin
sv := TDiscontinuousSV(distr);
r := random;
i:=0;
repeat
  x := sv.GetSVValueByIndex(i);
  inc(i);
  r := r - sv.p(x);
until r < 0;
result := x;
end;

{ TNeimonGeneratorForDiscontinuousSV }

constructor TNeimonGeneratorForDiscontinuousSV.Create(
  distribution: TDiscontinuousSV; maxIndex: integer);
begin
  inherited Create(distribution);
  self.maxI := maxIndex;
end;

function TNeimonGeneratorForDiscontinuousSV.Generate: double;
var
x: double;
begin
repeat
  x := TDiscontinuousSV(distr).GetSVValueByIndex(random(maxi));
until random < TDiscontinuousSV(distr).p(x);
result := x;
end;

end.
