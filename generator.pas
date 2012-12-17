unit generator;

{
Ётот модуль содержит описание абстрактных классов,
которые описывают генераторы значений случайных величин.
}

interface

uses sv;

type
  // ласс, генерирующий значение случайной величины
  TGenerator = class
  protected
    distr: TSv;
    //—лучайна€ величина
  public
    constructor Create(distribution: TSv);
    //distribution - класс, описывающий случайную величину

    destructor Destroy;

    function Generate():double;virtual;abstract;
    //метод, генерирующий значение случайной величины
  end;

{Ќепрерывные случайные величины}

  //√енератор, основанный на методе обратной функции
  TInvGenerator = class(TGenerator)
  public
    constructor Create(distribution: TContinuousSVWithInvF);
    //distribution - случайна€ величина с заданной обратной функцией функции распределени€

    function Generate():double;override;
    //метод, генерирующий значение случайной величины
  end;

//√енератор, основанный на методе Ќеймана дл€ непрерывной случайной величины
  TNeimonGeneratorForContinuousSV = class(TGenerator)
  private
    left, right, maxValue: double;
  public
    constructor Create(distribution: TContinuousSV; left, right, MaxValue: double);
    //distribution - непрерывна€ случайна€ величина
    //left, right - промежуток, с которым работает метод Ќеймана.
    //ќпределЄнный интеграл от left до right от функции плотности веро€тности должнен быть равен или стремитьс€ к единице
    //MaxValue - число, которое не меньше, чем глобальный максимум функции плотности веро€тности.

    function Generate():double;override;
    //метод, генерирующий значение случайной величины
  end;

{ƒискретные случайные величины}

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
