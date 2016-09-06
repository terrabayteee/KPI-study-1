Unit TestAlg;

interface
uses ar_dec,ar_fill,common;
const st = (p-1) div 4 + 1;
procedure test_insertion_1(var Ar:TArray);
procedure test_selection_8(var Ar:TArray);
procedure test_Shell(var Ar:TArray);
procedure test_QuickSort (var Ar:TArray);

implementation

procedure Out_put(var Ar:TArray);{Output of three-dimensional array}
var k,i,j:word;
begin
for k:=1 to p do
 begin
 for i:=1 to m do
  begin
  for j:=1 to n do
   write(Ar[k,i,j]:6);
  writeln;
  end;
  writeln;
 end;
end;

procedure test_insertion_1(var Ar:TArray);{Testing of algorithm insertion 1 for
three-dimensional array sorting and output array of summs before and after sorting}
var Suma:TVector;
S:longint;
R,k,i,j,c,b:word;
begin
filling_random(Ar);
Out_put(Ar);
S:=0;
for k:=1 to p do
 begin
 S:=0;
 for i:=1 to m do
  for j:=1 to n do
   S:=S+Ar[k,i,j];
 Suma[k]:=S;
 end;
for i:=1 to p do write('Sum of ',i,' slice =',Suma[i]:8,' ');
writeln;

for c:=2 to p do
 begin
 S:=Suma[c];
 b:=1;
 while S>Suma[b] do b:=b+1;
  for k:=c-1 downto b do
   Suma[k+1]:=Suma[k];
 for i:=1 to m do
  begin
  for j:=1 to n do
   begin
   R:=Ar[c,i,j];
   for k:=c-1 downto b do
    Ar[k+1,i,j]:=Ar[k,i,j];
   Ar[b,i,j]:=R;
   end;
  end;
 Suma[b]:=S;
 end;
for i:=1 to p do write('Sum of ',i,' slice =',Suma[i]:8,' ');
writeln;
Out_put(Ar);
end;

procedure test_selection_8(var Ar:TArray);{Testing of algorithm selection 1 for
three-dimensional array sorting and output array of summs before and after sorting}
var Suma:TVector;
S:longint;
L,R,i,j,k,kmin,kmax:word;
begin
filling_random(Ar);
Out_put(Ar);
S:=0;
for k:=1 to p do
 begin
 S:=0;
 for i:=1 to m do
  for j:=1 to n do
   S:=S+Ar[k,i,j];
 Suma[k]:=S;
 end;
for i:=1 to p do write('Sum of ',i,' slice =',Suma[i]:8,' ');
writeln;

L:=1; R:=p;
while L<R do
 begin
 kmin:=L; kmax:=L;
 for k:=L+1 to R do
  if Suma[k] < Suma[kmin] then
   kmin:=k
   else
   if Suma[k] > Suma[kmax] then
    kmax:=k;
 if kmin<>L then
  begin
  S:=Suma[kmin];
  Suma[kmin]:=Suma[L];
  Suma[L]:=S;
  for i:=1 to m do
   for j:=1 to n do
    begin
    S:=Ar[kmin,i,j];
    Ar[kmin,i,j]:=Ar[L,i,j];
    Ar[L,i,j]:=S;
    end;
  end;
 if kmax<>R then
  if kmax=L then
   begin
   S:=Suma[kmin];
   Suma[kmin]:=Suma[R];
   Suma[R]:=S;
   for i:=1 to m do
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
   for i:=1 to m do
    for j:=1 to n do
     begin
     S:=Ar[kmax,i,j];
     Ar[kmax,i,j]:=Ar[R,i,j];
     Ar[R,i,j]:=S;
     end;
   end;
 L:=L+1; R:=R-1;
 end;
for i:=1 to p do write('Sum of ',i,' slice =',Suma[i]:8,' ');
writeln;
Out_put(Ar);
end;

procedure test_Shell(var Ar:TArray); {Testing of algorithm Shell sorting for
three-dimensional array sorting and output array of summs before and after sorting}
var Suma:TVector; matr:array [1..m,1..n] of word;
Stages:array [1..st] of word;
S:longint;
R,q,i,j,b,c,k,v,t:word;
begin
filling_random(Ar);
Out_put(Ar);
S:=0;
for k:=1 to p do
 begin
 S:=0;
 for i:=1 to m do
  for j:=1 to n do
   S:=S+Ar[k,i,j];
 Suma[k]:=S;
 end;
for i:=1 to p do write('Sum of ',i,' slice =',Suma[i]:8,' ');
writeln;

if p<=4 then t:= 1
       else t:= Trunc(Ln(p)/Ln(2))-1;
Stages[t]:=1;
for b:=t-1 downto 1 do Stages[b]:=2*Stages[b+1]+1;
for v:=1 to t do
 begin
 k:=Stages[v];
 for b:=k+1 to p do
  begin
  c:=b;
  S:=Suma[b];

  while (c>k) and (S<Suma[c-k]) do
   begin
   Suma[c]:=Suma[c-k];
   c:=c-k;
   end;
  for i:=1 to m do
   for j:=1 to n do
    begin
    q:=b;
    R:=Ar[b,i,j];
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
for i:=1 to p do write('Sum of ',i,' slice =',Suma[i]:8,' ');
writeln;
Out_put(Ar);
end;

procedure test_QSort (L, R : word;var Suma:TVector);
var
Z,Tmp:longint;
i,j,c,b: word;
begin
Z:= Suma[(L+R) div 2]; c:=L; b:=R;
while c<=b do
 begin
 while Suma[c] < Z do c:=c+1;
 while Suma[b] > Z do b:=b-1;
 if c<=b then
  begin
  Tmp:=Suma[c]; 
  Suma[c]:=Suma[b];
  Suma[b]:=Tmp;
  for i:=1 to m do
   for j:=1 to n do
    begin
    Tmp:=Ar[c,i,j];
    Ar[c,i,j]:=Ar[b,i,j];
    Ar[b,i,j]:=Tmp;
    end;
  c:=c+1;
  b:=b-1;
  end;
 end;
if L<b then test_QSort(L,b,Suma);
if c<R then test_QSort(c,R,Suma);
end;

procedure test_QuickSort (var Ar:TArray);
var Suma:TVector;
S:longint;
k,i,j:word;
begin
filling_random(Ar);
Out_put(Ar);
S:=0;
for k:=1 to p do
 begin
 S:=0;
 for i:=1 to m do
  for j:=1 to n do
   S:=S+Ar[k,i,j];
 Suma[k]:=S;
 end;
for i:=1 to p do write ('Sum of ',i,' slice =',Suma[i]:8,' ');
writeln;
Test_QSort(1,p,Suma);
for i:=1 to p do write ('Sum of ',i,' slice =',Suma[i]:8,' ');
writeln;
Out_put(Ar);
end;
end.