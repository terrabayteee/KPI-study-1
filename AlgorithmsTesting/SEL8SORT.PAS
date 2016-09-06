Unit sel8sort;{unit contains selection 8 sorting algorithm
for three-dimensional array}
interface
uses ar_dec,common;
procedure selection_8(var Ar:TArray);

implementation
uses dos;
procedure selection_8(var Ar:TArray);
var Suma:TVector;{array of sums of slices}
S:longint;{S - additional memory cell to keep array of sums element}
L,R,i,j,k,kmin,kmax:word;
{L-memory cell to keep position of leftmost element of not sorted part of vector
R-memory cell to keep position of rightmost element of not sorted part of vector
k-external counter to create array of sums/counter to looking for position of
maximum and minimum elements of vector
kmin- position of minimum element of not sorted part of vector
kmax- position of maximum element of not sorted part of vector
i- middle counter to create array of sums/external counter of 
 three-dimensional array permutations 
j-internal counter to create array of sums/internal counter of 
 three-dimensional array permutations}

begin
with StartTime do  {saving system time of starting sorting}
 GetTime(Hours,Minutes,Seconds,HSeconds);
for k:=1 to p do           {creating array of sums}
 begin
 Suma[k]:=0;
 for i:=1 to m do
  for j:=1 to n do
   Suma[k]:=Suma[k]+Ar[k,i,j];
 end;

L:=1; R:=p;
while L<R do  {external cycle}
 begin
 kmin:=L; kmax:=L; {replacing position of minimum and maximum elements
 of not sorted part on leftmost position of not sorted part}
 for k:=L+1 to R do {cycle to find position of minimum and maximum elements 
 of not sorted part}
  if Suma[k] < Suma[kmin] then
   kmin:=k
   else
   if Suma[k] > Suma[kmax] then
    kmax:=k;
 if kmin<>L then {cycle to replace minimum element of not sorted part
 on leftmost position of not sorted part}
  begin
  S:=Suma[kmin];
  Suma[kmin]:=Suma[L];
  Suma[L]:=S;
  for i:=1 to m do {three-dimensional array permutations}
   for j:=1 to n do
    begin
    S:=Ar[kmin,i,j];
    Ar[kmin,i,j]:=Ar[L,i,j];
    Ar[L,i,j]:=S;
    end;
  end;
 if kmax<>R then {cycle to replace maximum element of not sorted part
 on rightmost position of not sorted part}
  if kmax=L then
   begin
   S:=Suma[kmin];
   Suma[kmin]:=Suma[R];
   Suma[R]:=S;
   for i:=1 to m do {three-dimensional array permutations}
    for j:=1 to n do
     begin
     S:=Ar[kmin,i,j];
     Ar[kmin,i,j]:=Ar[R,i,j];
     Ar[R,i,j]:=S;
     end;
   end
  else begin
   S:=Suma[kmax];
   Suma[kmax]:=Suma[R];
   Suma[R]:=S;
   for i:=1 to m do {three-dimensional array permutations}
    for j:=1 to n do
     begin
     S:=Ar[kmax,i,j];
     Ar[kmax,i,j]:=Ar[R,i,j];
     Ar[R,i,j]:=S;
     end;
   end;
 L:=L+1; R:=R-1; {replacing leftmost and rightmost positions on 1 position
 right and left respectively}
 end;
with FinishTime do  {saving system time of finishing sorting}
 GetTime(Hours,Minutes,Seconds,HSeconds);
end;
end.