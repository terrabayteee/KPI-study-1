unit menu;

interface 
procedure menucreate;

implementation
uses abcobjects,graphABC,gameinit;
var
menuitems1:array [1..3] of rectangleABC;{Array of punkts of menu}
menuitems2:array [1..3] of pictureABC;{Array of pictures for punkts om menu}
txt1:array [1..12] of TextABC;{array for text in help}
mframe:pictureABC;{frame as a cursor in menu}
k:integer; {variable to use not more then 1 help at one time}

procedure keystrokes(key: integer); forward;

procedure DestroyingHelp;{Destroing of objects after using help}
var i:byte;
begin
for i:=1 to 12 do
 txt1[i].Destroy;
end;




procedure DestroyingMenu; {Destroing of objects after using menu}
var i:byte;
begin
for i:=1 to 3 do
 begin
 menuitems1[i].Destroy;
 menuitems2[i].Destroy;
 end;
mframe.Destroy;
end;

procedure help; {creating of help}
begin
txt1[1]:=textABC.Create(250,50,25,'Help');
txt1[2]:=textABC.Create(100,100,10,'In this game you need to permute balls with each other');
txt1[3]:=textABC.Create(100,120,10,'to put at first white balls and after - black.');
txt1[4]:=textABC.Create(100,140,10,'You have half of number of balls moves to do that');
txt1[5]:=textABC.Create(250,170,15,'Controls');
txt1[6]:=textABC.Create(100,200,10,'Press "escape" to return to the menu');
txt1[7]:=textABC.Create(100,220,10,'Press "enter" to choose item of the menu');
txt1[8]:=textABC.Create(100,240,10,'Press "space" to choose the ball for permuting');
txt1[9]:=textABC.Create(100,260,10,'Press "left" to move your cursor on 1 ball to left');
txt1[10]:=textABC.Create(100,280,10,'Press "right" to move your cursor on 1 ball to right');
txt1[11]:=textABC.Create(100,300,10,'Press "up" to move your cursor on 1 point of menu to up /1 ball to up');
txt1[12]:=textABC.Create(100,320,10,'Press "down" to move your cursor on 1 point of menu to down /1 ball to down');

end;

procedure menucreate;{Creating of menu}
begin
setwindowsize(600,500);
menuitems1[1]:=rectangleABC.Create(100,50,300,50,clwhite);
menuitems1[1].bordered:=false;
menuitems1[1].text:='Play';
menuitems1[1].FontStyle:=fsBoldItalic;
menuitems2[1]:=pictureABC.Create(410,30,'play.png');
menuitems2[1].Scale(0.7);
menuitems1[2]:=rectangleABC.Create(100,150,300,50,clwhite);
menuitems1[2].bordered:=false;
menuitems1[2].text:='Help';
menuitems1[2].FontStyle:=fsBoldItalic;
menuitems2[2]:=pictureABC.Create(410,130,'help.png');
menuitems2[2].Scale(0.7);
menuitems1[3]:=rectangleABC.Create(100,250,300,50,clwhite);
menuitems1[3].bordered:=false;
menuitems1[3].text:='Exit';
menuitems1[3].FontStyle:=fsBoldItalic;
menuitems2[3]:=pictureABC.Create(420,240,'exit.png');
menuitems2[3].Scale(0.5);
mframe:=pictureABC.Create(85,31,'mframe.png');
mframe.scaleX:=0.9;
mframe.scaley:=0.2;
ToBack(mframe);
k:=0;
onKeyDown:=keystrokes;
end;

procedure keystrokes(key: integer);{reading keyboard events}
begin
	case (key) of
  vk_up:if mframe.Top > 31 then begin
                                mframe.MoveOn(0,-100);
                                end;
 
  vk_down: if mframe.top < 185 then begin
                                   mframe.MoveOn(0,100);
                                   end;
  vk_enter:  begin
             if mframe.Intersect(menuitems1[1]) then begin
                                                     DestroyingMenu;
                                                     game;
                                                     end;
             if mframe.Intersect(menuitems1[2]) then begin
                                                     DestroyingMenu;
                                                     k:=k+1;
                                                     if k=1 then help;
                                                     end;
             
             if mframe.Intersect(menuitems1[3]) then halt;
              end;  
  vk_escape:  begin
              DestroyingHelp;
              menucreate;
              end;
 end;
                            
 
 
end;

begin
end.
