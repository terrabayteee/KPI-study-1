unit gameinit;{Unit initiate game start}

interface
procedure game;

implementation
uses menu,abcobjects,graphABC;
const m=4;n=4;{constants to create array}
var
Board: ObjectBoardABC; 
hole: CircleABC;
pict: PictureABC;{Picture 'winner' or 'game over'}
ball: PictureABC;
fun: PictureABC; {Picture 'have fun'}
frame: PictureABC; {frame as a cursor in game}
rect: RectangleABC; {Rectangle for number of moves that lefts}
txt1,txt2: TextABC; {2 strings to write about number of moves that lefts}
balls: array [1..m,1..n] of pictureABC;
holes: array [1..m,1..n] of CircleABC;
Ar:array[1..m,1..n] of byte;{array that keep color of every ball where 0-black and 1-white }
x,y,x1,y1,x2,y2:word; Fl,Fl2:boolean;{x,y - current ball at what placed cursor
x1,y1 - 1st picked ball, x2,y2 - 2-nd picked ball; Fl-flag that controls where are
1-st and 2-nd balls, Fl2 - flag that controls is not game task finished yet}
k,q:byte;{k- current number of used moves, q - variable for replacement in array Ar}


procedure DestroyingObjects;{Dostroying objects of game after game}
var i,j:byte;
begin
frame.destroy;
for i:=1 to m do
 for j:=1 to n do
  begin 
  Balls[i,j].Destroy;
  Holes[i,j].Destroy;
  end;
board.Destroy;
rect.Destroy;
txt1.Destroy;
txt2.Destroy;
fun.Destroy;
end;

procedure CheckForOrder;{Cheking for is game task finished}
var i,j:byte;
begin
Fl2:=true;
for i:=1 to m do
 begin
 j:=1;
 if i>1 then
         if Ar[i,j]>Ar[i-1,n] then Fl2:=false;
 for j:=2 to n do
  if Ar[i,j]>Ar[i,j-1] then Fl2:=false; 
 end; 
end;
 
procedure CreatingFieldToPlay;{creating field for game}
var i,j:byte;
begin
randomize;
fun:=pictureABC.Create(20+n*100,m*40,'HaveFun.png');
fun.scaleX:=0.6;
fun.ScaleY:=m*3/20;
setwindowsize(250+n*100,m*100);
Board:= ObjectBoardABC.create(0,0,n,m,100,100,clbrown);
ToBack(Board);
x:=0;y:=0;k:=0;
for i:=1 to m do
 for j:=1 to n do
  begin
  hole:= new circleABC(50+x,50+y,40,clblack);
  hole.Filled:=false;
  hole.BorderWidth:=10;
  x:=x+100;
  if j = n then
   begin 
   x:=0;
   y:=y+100;
   end;
  holes[i,j]:=hole; 
  end;
x:=0;y:=0; 
for i:=1 to m do
 for j:=1 to n do
  begin
  Ar[i,j]:=random(2); 
  if Ar[i,j]=0
  then
   begin
   ball:=pictureabc.Create(18+x,19+y,'black_ball.png');
   ball.Scale(1.4);
   balls[i,j]:=ball;
   x:=x+100;
   if j=n then
    begin 
    x:=0;
    y:=y+100;
    end;
   end
  else
   begin 
   ball:=pictureabc.Create(18+x,19+y,'white_ball.png');
   ball.Scale(1.4);
   balls[i,j]:=ball;
   x:=x+100;
   if j=n then
    begin 
    x:=0;
    y:=y+100;
    end;
   end; 
  end;
frame:=pictureabc.Create(0,0,'ramk216.png');
frame.scale(0.035);
txt1:=TextABC.Create(20+n*100,0,16,'the remaining number');
txt1.TransparentBackground:=false;
txt1.BackgroundColor:=clred;
txt2:=TextABC.Create(20+n*100,20,16,'moves:');
txt2.TransparentBackground:=false;
txt2.BackgroundColor:=clred;
rect:=RectangleABC.Create(20+n*100,50,round(100*n/4),round(100*m/4),Clwhite);
rect.number:= round(m*n/2-k);
rect.color:=clyellow;
end;

procedure keystrokes(key: integer);{reading keyboard events}
begin
	case (key) of
 vk_left: if frame.Left>0 then   begin
                                 frame.MoveOn(-100,0);
                                 x:=x-100;
                                 end;
 
 vk_right: if frame.Left<(n-1)*100 then begin
                                        frame.MoveOn(100,0);
                                        x:=x+100;
                                        end;
 vk_up:if frame.Top > 0 then  begin
                              frame.MoveOn(0,-100);
                              y:=y-100;
                              end;
 
 vk_down: if frame.top < (m-1)*100 then begin
                                        frame.MoveOn(0,100);
                                        y:=y+100;
                                        end;
 vk_space: if Fl=false
  then begin
       Fl:=True;
       x1:=x;
       y1:=y;
       end                   
   else begin
        Fl:=false;
        x2:=x;
        y2:=y;
        swappositions (balls[round((y1+81)/100),round((x1+82)/100)],
        balls[round((y2+81)/100),round((x2+82)/100)]);
        ball:=balls[round((y1+81)/100),round((x1+82)/100)];
        balls[round((y1+81)/100),round((x1+82)/100)]:=balls[round((y2+81)/100),round((x2+82)/100)];
        balls[round((y2+81)/100),round((x2+82)/100)]:=ball;
        q:=Ar[round((y1+81)/100),round((x1+82)/100)];
        Ar[round((y1+81)/100),round((x1+82)/100)]:=Ar[round((y2+81)/100),round((x2+82)/100)];
        Ar[round((y2+81)/100),round((x2+82)/100)]:=q;
        k:=k+1;
        rect.number:= round(m*n/2-(k+0.25));
        CheckForOrder;
        if Fl2=true  then begin
                          DestroyingObjects;
                          setwindowsize(400,400);
                          pict:=pictureabc.Create(0,0,'winner4.png');
                          sleep(5000);
                          pict.Destroy;
                          Menucreate;
                          end;
         if k>= m*n/2-0.5 then begin
                          DestroyingObjects;
                          setwindowsize(400,400);
                          pict:=pictureabc.Create(0,0,'gameover.png');
                          pict.Scale(4/3);                                                             
                          sleep(5000);  
                          pict.Destroy;
                          Menucreate;
                          end;
                        
        end;
                            
 
 vk_escape: begin
            DestroyingObjects;
            Menucreate;
            end;
 end;
end;

procedure game;{iniciating game}
begin
CreatingFieldToPlay;
x:=18;y:=19;Fl:=false;
onKeyDown:=keystrokes;
end;

begin
end.