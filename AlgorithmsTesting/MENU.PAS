Unit menu;{Unit contains interactive interface to choose algorithm for testing
or to choose algotithm(s) to calculate time that they needed}

Interface
procedure menu1;
procedure headband;

Implementation
uses crt,common,OutPut,ins1sort,sel8sort,shelsort,hoarsort,TestAlg,
ar_fill,ar_dec;

procedure frame (x1,y1,x2,y2:integer);{Procedure painting frame}
var i:integer;
begin
gotoxy(x1,y1);write(#201);
for i:=(x1+1) to (x2-1) do write (#205);
 write (#187);
for i:=(y1+1) to (y2-1) do
 begin
 gotoxy(x1,i);write(#186);
 gotoxy(x2,i);write(#186);
 end;
gotoxy (x1,y2); write(#200);
for i:=(x1+1) to (x2-1) do write (#205);
write(#188);
end;

procedure headband;{Procedure show a headband before menu starting}
begin
clrscr;
frame(1,1,80,20);
gotoxy(34,2);write('NTUU KPI');
gotoxy(34,10);write('Curse Work ');
gotoxy(34,12);write('Variant #7');
gotoxy(65,15);write('Buts Yaroslav');
gotoxy(65,17);write('KV-42');
delay(3000);
end;

procedure part_of_menu1;{repeating part of menu1}
begin
clrscr; frame(1,1,80,22);
gotoxy(15,5);write('Choose the algorithm of sorting to measure time');
gotoxy(20,7);write('Use insertion 1 sorting');
gotoxy(20,9);write('Use selection 8 sorting');
gotoxy(20,11);write('Use Shell sorting');
gotoxy(20,13);write('Use Hoar sorting');
gotoxy(20,15);write('Use all 4 algorithms');
gotoxy(20,17);write('Test algorithms');
gotoxy(20,19);write('Exit');
end;

procedure part_of_menu2;{repeating part of menu2}
begin
clrscr; frame(1,1,80,20);
gotoxy(15,5);write('Choose the algorithm of sorting to test');
gotoxy(20,7);write('Use insertion 1 sorting');
gotoxy(20,9);write('Use selection 8 sorting');
gotoxy(20,11);write('Use Shell sorting');
gotoxy(20,13);write('Use Hoar sorting');
gotoxy(20,15);write('Return to the previus menu');
end;

procedure menu2;{Procedure that is interactive interface
to choose algorithm to test}
var ch:char;i,x1,x2,y1,y2:byte;
begin
x1:=19;y1:=6;x2:=50;y2:=8;
part_of_menu2;
frame(x1,y1,x2,y2);
ch:=readkey;i:=1;
while ch<>#13 do
 begin
 clrscr;
 case ch of
  #80:begin
      if i<5 then begin
                  y1:=y1+2;
                  y2:=y2+2;
                  clrscr;
                  part_of_menu2;
                  frame(x1,y1,x2,y2);
                  inc(i);
                  end
             else begin
                  part_of_menu2;
                  frame(x1,y1,x2,y2);
                  end;
      end;
  #72:begin
      if i>1 then begin
                  y1:=y1-2;
                  y2:=y2-2;
                  clrscr;
                  part_of_menu2;
                  frame(x1,y1,x2,y2);
                  i:=i-1;
                  end
             else begin
                  part_of_menu2;
                  frame(x1,y1,x2,y2);
                  end;
      end;
  end;
 ch:=readkey;
 end;
clrscr;
case i of
 1: begin
    test_insertion_1(Ar);
    readln;
    menu2;
    end;
 2: begin
    test_selection_8(Ar);
    readln;
    menu2;
    end;
 3: begin
    test_Shell(Ar);
    readln;
    menu2;
    end;
 4: begin
    test_QuickSort(Ar);
    readln;
    menu2;
    end;
 5: ;

 end;
end;

procedure menu1; {Procedure that is interactive interface
to choose algorithm to get time that theu needed}
var ch:char;i,x1,x2,y1,y2:byte;
begin
x1:=19;y1:=6;x2:=50;y2:=8;
part_of_menu1;
frame(x1,y1,x2,y2);
ch:=readkey;i:=1;
while ch<>#13 do
 begin
 clrscr;
 case ch of
  #80:begin
      if i<7 then begin
                  y1:=y1+2;
                  y2:=y2+2;
                  clrscr;
                  part_of_menu1;
                  frame(x1,y1,x2,y2);
                  inc(i);
                  end
             else begin
                  part_of_menu1;
                  frame(x1,y1,x2,y2);
                  end;
      end;
  #72:begin
      if i>1 then begin
                  y1:=y1-2;
                  y2:=y2-2;
                  clrscr;
                  part_of_menu1;
                  frame(x1,y1,x2,y2);
                  i:=i-1;
                  end
             else begin
                  part_of_menu1;
                  frame(x1,y1,x2,y2);
                  end;
      end;
  end;
 ch:=readkey;
 end;
clrscr;
case i of
 1: begin
    NameOfAlg:='Insertion 1';
    Talg:=insertion_1;
    OutTime(i);
    end;
 2: begin
    NameOfAlg:='Selection 8';
    Talg:=selection_8;
    OutTime(i);
    end;
 3: begin
    NameOfAlg:='Shell';
    Talg:=Shell;
    OutTime(i);
    end;
 4: begin
    NameOfAlg:='Quick Sort';
    Talg:=QuickSort;
    OutTime(i);
    end;

 5: begin
    OutTime(i);
    end;
 6: begin menu2; menu1; end;
 7: exit;
 end;
end;
end.