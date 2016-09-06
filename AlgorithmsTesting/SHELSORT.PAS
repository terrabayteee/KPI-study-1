        Unit Shelsort;{unit contains Shell sorting algorithm for three-dimensional array}
interface
uses ar_dec,common;
procedure Shell(var Ar:TArray);

implementation
uses dos;
const st = (p-1) div 4 + 1;{constant to create array of stages of algorithm}

procedure Shell(var Ar:TArray);
var Suma:TVector; {array of sums of slices}
Stages:array [1..st] of word; {array of stages of algorithm}
S:longint;{S - additional memory cell to keep array of sums element}
R,q,i,j,b,c,k,v,t:word;
{R - additional memory cell to keep three-dimensional array element
 k - external counter to create array of sums/current step in replacing
 i - middle counter to create array of sums/external counter of
 three-dimensional array permutations
 j - internal counter to create array of sums/middle counter of
 three-dimensional array permutations
 t - additional memory cell to keep number of groups of steps
 b - counter to fill array Stages/middle counter of vector sorting
 v - external counter of vector sorting
 c - internal counter of vector sorting
 q - internal counter of three-dimensional array permutations}
begin
with StartTime do  {saving system time of starting sorting}
 GetTime(Hours,Minutes,Seconds,HSeconds);
for k:=1 to p do     {creating array of sums}
 begin
 Suma[k]:=0;
 for i:=1 to m do
  for j:=1 to n do
   Suma[k]:=Suma[k]+Ar[k,i,j];
 end;

if p<=4 then t:= 1    {choosing the number of groups of steps}
       else t:= Trunc(Ln(p)/Ln(2))-1;
Stages[t]:=1;        {saving first step}
for b:=t-1 downto 1 do Stages[b]:=2*Stages[b+1]+1;{calculation and saving
 others steps}
for v:=1 to t do {external cycle of vector sorting}
 begin
 k:=Stages[v];
 for b:=k+1 to p do {middle cycle of vector sorting}
  begin
  S:=Suma[b];
  c:=b;
  while (c>k) and (S<Suma[c-k]) do {internal cycle of vector sorting}
   begin
   Suma[c]:=Suma[c-k];
   c:=c-k;
   end;
  for i:=1 to m do {external cycle of three-dimensional array permutations}
   for j:=1 to n do {internal cycle of three-dimensional array permutations}
    begin
    R:=Ar[b,i,j];
    q:=b;
    while (q>k) and (S<Suma[q-k]) do
     begin
     Ar[q,i,j]:=Ar[q-k,i,j];
     q:=q-k;
     end;
    Ar[q,i,j]:=R;
    end;
  Suma[c]:=S;
  end;
 end;

with FinishTime do  {saving system time of finishing sorting}
 GetTime(Hours,Minutes,Seconds,HSeconds);
end;
end.