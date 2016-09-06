Unit Hoarsort;{unit contains Quick sorting algorithm for three-dimensional array}
interface
uses ar_dec,common;
procedure QuickSort (var Ar:TArray);
implementation
uses dos;
var Suma:TVector;{array of sums of slices}

procedure QSort (L, R : word);{internal procedure in sorting}
{L - memory cell to keep position of leftmost element of current distance
R - memory cell to keep position of rightmost element of current distance}
var S, Tmp : longint;
c,b,i,j : word;
{S - additional memory cell to keep supporting element
 Tmp - additional memory cell to keep array of sums element
 c - counter that operates on the left side of current distance and keeping
 position of element that is placed on the wrong side from supporting element
 b - counter that operates on the right side of current distance and keeping
 position of element that is placed on the wrong side from supporting element
 i - external counter of three-dimensional array permutations
 j - internal counter of three-dimensional array permutations}
begin
S:=Suma[(L+R) div 2]; c:=L; b:=R; {choosing new supportin element
 and placing counters on leftmost and rightmost elements}
while c<=b do {external cycle of replacing elements on right sides
 from supporting element}
 begin
 while Suma[c] < S do c:=c+1; {looking for elements on wrong sides from}
 while Suma[b] > S do b:=b-1; {supporting elements}
 if c<=b then {internal cycle of replacing elements on right sides
 from supporting element}
  begin
  Tmp:=Suma[c];
  Suma[c]:=Suma[b];
  Suma[b]:=Tmp;
   for i:=1 to m do {external cycle of three-dimensional array permutations}
    for j:=1 to n do {internal cycle of three-dimensional array permutations}
     begin
     Tmp:=Ar[c,i,j];
     Ar[c,i,j]:=Ar[b,i,j];
     Ar[b,i,j]:=Tmp;
     end;
  c:=c+1; {replacing left side counter and right side counter}
  b:=b-1; {on 1 position right and left respectively}
  end;
 end;
if L<b then QSort(L,b); {recursive calls of procedure}
if c<R then QSort(c,R);
end;

procedure QuickSort (var Ar:TArray);{procedure of sorting}
var S:longint;{S - additional memory cell to keep array of sums element}
k,i,j:word;
{k - external counter to create array of sums
 i - middle counter to create array of sums
 j - internal counter to create array of sums}
begin
with StartTime do  {saving system time of starting sorting}
 GetTime(Hours,Minutes,Seconds,HSeconds);
for k:=1 to p do   {creating array of sums}
 begin
 Suma[k]:=0;
 for i:=1 to m do
  for j:=1 to n do
   Suma[k]:=Suma[k]+Ar[k,i,j];
 end;
QSort(1,p);
with FinishTime do {saving system time of finishing sorting}
 GetTime(Hours,Minutes,Seconds,HSeconds);
end;
end.
