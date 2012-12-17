unit sv;

{
���� ������ �������� �������� ����������� �������, ������� ��������� ��������� ��������
}

interface

uses classes;

type
  TPairDouble = class
  private
    key, value: double;
  public
    constructor Create(key, value: double);
  end;

  //�����, ����������� ��������� ��������
  TSV = class
  end;

{����������� ��������� ��������}

  //����������� ��������� ��������
  TContinuousSV = class(TSV)
  public
    function p(x: double):double;virtual;abstract;
    //������� ��������� �������������
  end;

  //����������� ��������� �������� � �������� �������� ��������
  TContinuousSVWithInvF = class(TContinuousSV)
  public
    function invF(x: double):double;virtual;abstract;
    //�������� ������� ������� �������������
  end;

  //����������� ��������� �������� � �������������� �������� �������� �������
  TContinuousSVWithAutoInvF = class(TContinuousSVWithInvF)
  private
    list: Tlist;
    //������� �������� �������� ������� ������� �������������
  protected
    initialized: boolean;
    //�������� ������� ����������������

    minX, maxX: double;
    //����������� � ������������ X � ������� �������� �������� �������

    procedure InitializeInvF(ZeroValueX, OneValueX: double);
    //���������� ������� �������� �������
  public
    constructor Create(minX, maxX: double);
    //mixX - �������� X, ��� ������� ������� ������������� ����� ��� ���������� � ���� (����� ������)
    //maxX -�������� X, ��� ������� ������� ������������� ����� ��� ���������� � ������� (������ ������)

    destructor Destroy;override;

    function invF(x: double):double;override;
    //�������� ������� ������� �������������
  end;

{���������� ��������� ��������}

  TDiscontinuousSV = class(TSV)
    function p(x: double):double;virtual;abstract;
    //������� �����������

    function GetSVValueByIndex(index: integer):double;virtual;abstract;
    //����� ���������� i-��� ��������� �������� ��������� �������� (i �� 0 � ������)
  end;

implementation

uses sysutils;

{ TContinuousSVWithAutoInvF }

constructor TContinuousSVWithAutoInvF.Create(minX, maxX: double);
begin
initialized := false;
self.minX := minX;
self.maxX := maxX;
list := Tlist.Create;
end;

destructor TContinuousSVWithAutoInvF.Destroy;
begin
list.Clear;
list.Destroy;
inherited Destroy;
end;

procedure TContinuousSVWithAutoInvF.InitializeInvF(ZeroValueX, OneValueX: double);
var
x, dx, sum, tmp: double;
i, n: integer;
begin
  sum := 0;
  n := 1000000;
  dx := (OneValueX - ZeroValueX) / n;
  for i:=0 to n-1 do
  begin
    x := ZeroValueX + dx*i;
    sum := sum + p(x);
    list.Add(TPairDouble.Create(x, sum*dx));
  end;
  initialized := true;
end;

function TContinuousSVWithAutoInvF.invF(x: double): double;
var
l, r, t: integer;
p: TPairDouble;
begin
if (x<0) or (x>1) then raise Exception.Create('������������ �������� �������� �������');

if not initialized then InitializeInvF(minX, MaxX);

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

end.
