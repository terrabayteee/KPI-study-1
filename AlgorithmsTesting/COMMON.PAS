Unit common;{Unit contains all needed in program global variables and types}

interface
const p=2048;m=2;n=2; {constants to create array}
type TArray = array [1..p,1..m,1..n] of word; {type to three-dimentional array}
TVector = array [1..p] of longint; {type to one-dimentional array}
TTime = record             {type to keep system time in record}
         Hours,
         Minutes,
         Seconds,
         Hseconds:word
        end;
TAlgorithm = procedure(var Ar:TArray);{type to keep current algorithm}
var StartTime,FinishTime:TTime;
{variables to keep time of starting and finishing current sorting}
TimeVect:array [1..10] of longint;{array to keep duration
of current sorting algorithm(10 times to increase accuracy)}
TAlg,TFill:TAlgorithm;{variables to keep current sorting and filling algorithm}
NameOfAlg:string;{string to keep name of current sorting algorithm}
implementation
end.