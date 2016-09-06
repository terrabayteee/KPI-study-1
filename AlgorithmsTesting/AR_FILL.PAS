Unit ar_fill;{unit contains procedures to fill three-dimensional array
with random element, ordered to task and reverse ordered to task}

interface
uses crt,ar_dec,common;
procedure filling_random(var Ar:TArray);
procedure filling_ordered(var Ar:TArray);
procedure filling_reverse_ordered(var Ar:TArray);

implementation
procedure filling_random(var Ar:TArray); {procedure to fill}
var k,i,j,z:word; S:longint;             {a three-dimensional array}
begin                                    {with random elements}
randomize;                                
for k:=1 to p do
 for i:=1 to m do
  for j:=1 to n do
   for z:=1 to 5 do  {cycle to increase maximum element with random filling}
   begin
   S:=S+random(65535);
   Ar[k,i,j]:=S;
   end;
end;

procedure filling_ordered(var Ar:TArray); {procedure to fill}
var k,i,j:word;                           {a three-dimensional array}
begin                                     {with ordered to task elements}
for k:=1 to p do
 for i:=1 to m do
  for j:=1 to n do
   Ar[k,i,j]:=i+k;
end;

procedure filling_reverse_ordered(var Ar:TArray);{procedure to fill}
var k,i,j:word;                                  {a three-dimensional array}
begin                                            {with reverse ordered}
for k:=1 to p do                                 {to task elements}
 for i:=1 to m do
  for j:=1 to n do
   Ar[k,i,j]:=50000-i*j*k; 
end;
end.  