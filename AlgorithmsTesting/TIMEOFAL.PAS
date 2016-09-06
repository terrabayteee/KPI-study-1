Unit Timeofal;

interface
uses dos,common;
function ResTime (const STime, Ftime:TTime):longint;
function AverageTime:real;

implementation
uses ar_dec;

function ResTime (const STime, Ftime:TTime):longint; {Function that return
difference between starting time and finishing time}
begin
ResTime:= 360000*longint(FTime.Hours)+6000*longint(FTime.Minutes)
+100*longint(FTime.Seconds)+longint(FTime.HSeconds)
-360000*longint(STime.Hours)-6000*longint(STime.Minutes)
-100*longint(STime.Seconds)-longint(STime.HSeconds);
end;

procedure CreatingTimeVect; {Pocedure that using function ResTime 10 times and
saving this results in array TimeVect}
var i:byte;
begin
for i:=1 to 10 do
 begin
 TFill(Ar);
 TAlg(Ar);
 TimeVect[i]:=ResTime(StartTime,FinishTime);
 end;
end;

function AverageTime:real;{Function that using array TimeVect. It counting
average time from 3 to 10 elements of TimeVect excluding maximum of them}
var i:byte; max,S:longint;
begin
S:=0;
CreatingTimeVect;
max:=TimeVect[3];
for i:=4 to 10 do
 if TimeVect[i]>max then max:=TimeVect[i];
for i:=3 to 10 do
 S:=S+TimeVect[i];
AverageTime:=(S-max)/7;
end;

end.