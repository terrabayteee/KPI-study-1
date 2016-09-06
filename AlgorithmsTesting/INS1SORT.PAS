Unit ins1sort;{unit contains insertion 1 sorting algorithm
for three-dimensional array}
interface
uses ar_dec,common;
procedure insertion_1(var Ar:TArray);

implementation
uses dos;
procedure insertion_1(var Ar:TArray);
var Suma:TVector;{array of sums of slices}
S:longint;{S - additional memory cell to keep array of sums element}
R,k,i,j,c,b:word; 
{R - additional memory cell to keep three-dimensional array element
 k - external counter to create array of sums/counter to perform cyclic shift
 c - external counter of vector sorting
 b - counter to find a place for vector insertion
 i - middle counter to create array of sums/external counter of 
 three-dimensional array permutations 
 j - internal counter to create array of sums/internal counter of 
 three-dimensional array permutations }
begin
with StartTime do {saving system time of starting sorting}
 GetTime(Hours,Minutes,Seconds,HSeconds);

for k:=1 to p do       {creating array of sums}    
 begin
 Suma[k]:=0;
 for i:=1 to m do
  for j:=1 to n do
   Suma[k]:=Suma[k]+Ar[k,i,j];
 end;

for c:=2 to p do {external cycle of sorting}
 begin
 S:=Suma[c];
 b:=1;
 while S>Suma[b] do b:=b+1; {looking for a place to insertion}
 for k:=c-1 downto b do  {cyclic shift}
  Suma[k+1]:=Suma[k];
 for i:=1 to m do {external cycle of three-dimensional array permutations}
  begin
  for j:=1 to n do {internal cycle of three-dimensional array permutations}
   begin
   R:=Ar[c,i,j];
   for k:=c-1 downto b do
    Ar[k+1,i,j]:=Ar[k,i,j];
   Ar[b,i,j]:=R;
   end;
  end;
 Suma[b]:=S;
 end;
with FinishTime do  {saving system time of finishing sorting}
 GetTime(Hours,Minutes,Seconds,HSeconds);
end;
end.
