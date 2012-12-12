unit SortedList;

interface

type
  TSortedListIterator = class;

  TElem = class
  private
    value: double;
    next: TElem;
  end;


  TSortedList = class
  private
    size: integer;
    list: TElem;
  public
    constructor Create;
    destructor Destroy;override;
    procedure Add(value: double);
    function Iterator: TSortedListIterator;
  end;

  TSortedListIterator = class
  private
    slist: TSortedList;
    p: TElem;
    constructor Create(slist: TSortedList);
  public
    function Value: double;
    function Next: boolean;
    function end_:boolean;
  end;


implementation

{ TSortedList }

procedure TSortedList.Add(value: double);
var
e, p: TElem;
begin
  e := TElem.Create;
  e.value := value;
  e.next := nil;
  p := list;
  if list = nil then
    list := e
  else
  begin
  if list.value > value then
  begin
    e.next := list;
    list := e;
  end
  else
  begin
    while (p.next <> nil) and (p.next.value < value) do p := p.next;
    e.next := p.next;
    p.next := e;
  end
  end
end;

constructor TSortedList.Create;
begin
  size := 0;
  list := nil;
end;

{ TSoertedListIterator }

constructor TSortedListIterator.Create(slist: TSortedList);
begin
  self.slist := slist;
  p := slist.list;
end;

function TSortedListIterator.end_: boolean;
begin
result := p = nil;
end;

function TSortedListIterator.Next: boolean;
begin
  if p = nil then result := false
  else
  begin
    p := p.next;
    result := true;
  end
end;

function TSortedListIterator.Value: double;
begin
  result := p.value;
end;

destructor TSortedList.Destroy;
var
p: TElem;
begin
while list <> nil do
begin
  p := list;
  list := list.next;
  p.Destroy;
end;
inherited destroy; 
end;

function TSortedList.Iterator: TSortedListIterator;
begin
if list = nil then result := nil
else result := TSortedListIterator.Create(self);
end;

end.
 