Unit Output;{Unit contain Output results of time calculate as a table}

interface
procedure OutTime(i:byte);

implementation
uses common,ar_fill,menu,TimeOfAl,ins1sort,sel8sort,shelsort,hoarsort;

procedure PartOfOut;{repeating part of OutTime}
begin
TFill:=filling_ordered;
write('| ',NameOfAlg:11,'          | ',AverageTime:11:2,'    | ');
TFill:=filling_random;
write(AverageTime:11:2,'    | ');
TFill:=filling_reverse_ordered;
writeln(AverageTime:11:2,'       |');
writeln('|----------------------------------------------------------------------------|');
end;

procedure OutTime(i:byte);{Output results of time calculate as a table}
begin
writeln('array [1..p,1..m,1..n]   p=',p,' m= ',m,' n= ',n);
if i<>5
then
 begin
 writeln('|----------------------------------------------------------------------------|');
 writeln('| Type of algorithm    |  Ordered       |  Not ordered   |  Reverse ordered  |');
 writeln('|----------------------------------------------------------------------------|');
 PartOfOut;
 end
else
 begin
 writeln('|----------------------------------------------------------------------------|');
 writeln('| Type of algorithm    |  Ordered       |  Not ordered   |  Reverse ordered  |');
 writeln('|----------------------------------------------------------------------------|');
 NameOfAlg:='Insertion 1';
 TAlg:=insertion_1;
 PartOfOut;
 NameOfAlg:='Selection 8';
 TAlg:=selection_8;
 PartOfOut;
 NameOfAlg:='Shell';
 TAlg:=Shell;
 PartOfOut;
 NameOfAlg:='Quick Sort';
 TAlg:=QuickSort;
 PartOfOut;
 end;
readln;
menu1;
end;
end.