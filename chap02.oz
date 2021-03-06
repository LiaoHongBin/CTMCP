declare
proc {Max X Y ?Z}
   if X>=Y then Z=X else Z=Y end
end

declare C
{Max 1 2 C}
{Browse C}

declare A B C in
C=A+B
{Browse C}
A=10
B=200

local P Q in
   proc {Q X} {Browse start(X)} end
   proc {P X} {Q X} end
   local Q in
      proc {Q X} {Browse dyn(X)} end
      {P hello}
   end
end

local X Y Z in
   f(X b) = f(a Y)
   f(Z a) = Z
   {Browse [X Y Z]}
end

declare X Y Z in
a(X c(Z) Z) = a(b(Y) Y d(X))
{Browse X#Y#Z}

declare L1 L2 L3 Head Tail in
L1 = Head|Tail
Head = 1
Tail = 2|nil

L2 = [1 2]
{Browse L1==L2}

L3='|'(1:1 2:'|'(2 nil))
{Browse L1==L3}

declare L1 L2 X in
L1=[1]
L2=[X]
{Browse L1==L2}

X=1

X=2


declare L1 L2 X in
L1=[X]
L2=[X]
{Browse L1==L2}

declare L1 L2 X in
L1=[1 a]
L2=[X b]
{Browse L1==L2}

declare
fun {Eval E}
   if {IsNumber E} then E
   else
      case E
      of plus(X Y) then {Eval X} + {Eval Y}
      [] times(X Y) then {Eval X} * {Eval Y}
      else raise illFormedExpr(E) end
      end
   end
end

try
   {Browse {Eval plus(plus(5 5) 10)}}
   {Browse {Eval times(3 7)}}
   {Browse {Eval minus(8 2)}}
catch illFormedExpr(E) then
   {Browse 'aaa'#E#'bbb'}
end


% ex
declare MulByN N in
N=3
proc {MulByN X ?Y}
   Y=N*X
end

declare A = 10  B

{MulByN A B}
{Browse B}

% 一度 Oz を終了させる
declare A = 10  B

local MulByN in
   local N in
      N = 3
      proc {MulByN X ?Y}
         Y=N*X
      end
   end
   {MulByN A B}
   {Browse B}
end

local MulByN N in
   local N in
      N = 3
      proc {MulByN X ?Y}
         Y=1N*X
      end
   end
   N=10
   {MulByN A B}
   {Browse B}
end

% ex. 3
declare
fun {Iftest N}
   if N==1 then
      10
   end
end

{Browse {Iftest 1}}
try
   {Browse {Iftest 2}}
catch X then
   {Browse X}
end

declare
fun {Iftest2 N}
   if N==1 then
      10
   else
      false
   end
end

{Browse {Iftest2 1}}
{Browse {Iftest2 2}}

declare
proc {IftestProc N ?R}
   if N==1 then
      R=10
   end
end

declare R
{IftestProc 2 R}
{Browse R}

% ex. 4

declare
fun {IfWithCase P C A}
   case P
   of true then {C}
   else {A}
   end
end

{Browse {IfWithCase
         1==1
         fun {$} 10 end
         fun {$} 5 end
        }} 

{Browse {IfWithCase
         1==2
         fun {$} 10 end
         fun {$} 5 end
        }} 

% https://github.com/Altech/ctmcp-answers/blob/master/Section02/exer04.oz

% ex. 5

declare
proc {Test X}
   case X
   of a|Z then {Browse 'case'(1)}
   [] f(a) then {Browse 'case'(2)}
   [] Y|Z andthen Y==Z then {Browse 'case'(3)}
   [] Y|Z then {Browse 'case'(4)}
   [] f(Y) then {Browse 'case'(5)}
   else {Browse 'case'(6)} end
end

{Test [b c a]}
{Test f(b(3))}
{Test f(a)}
{Test f(a(3))}
{Test f(d)}
{Test [a b c]}
{Test [c a b]}
{Test a|a}
{Test '|'(a b c)}
{Browse '|'(a b c)}

{Test b|b}

declare
proc {Test X}
   case X of f(a Y c) then {Browse 'case'(1)}
   else {Browse 'case'(2)} end
end

declare X Y
{Test f(X b Y)}
X=a
Y=c

declare X Y
{Test f(a Y d)}

declare X Y
{Test f(X Y d)}
X=a

declare X Y
if f(X Y d) == f(a Y c) then {Browse 'case'(1)}
else {Browse 'case'(2)} end

declare Max3 Max5
proc {SpecialMax Value ?SMax}
   fun {SMax X}
      if X>Value then X else Value end
   end
end
{SpecialMax 3 Max3}
{SpecialMax 5 Max5}
{Browse [{Max3 4} {Max5 4}]}

declare
fun {AndThen BP1 BP2}
   if {BP1} then {BP2} else false end
end

local X Y in
   X = {NewCell 0}
   Y = 
    {AndThen
     fun {$}
        X:=1
        false
     end
     fun {$}
        X:=2
        true
     end
    }
   {Browse @X}
   {Browse Y}
end

local X Y in
   X = {NewCell 0}
   Y = 
    {AndThen
     fun {$}
        X:=1
        true
     end
     fun {$}
        X:=2
        true
     end
    }
   {Browse @X}
   {Browse Y}
end

declare
fun {OrElse BP1 BP2}
   if {BP1} == false then {BP2} else true end
end

local X Y in
   X = {NewCell 0}
   Y = 
    {OrElse
     fun {$}
        X:=1
        true
     end
     fun {$}
        X:=2
        true
     end
    }
   {Browse @X}
   {Browse Y}
end

local X Y in
   X = {NewCell 0}
   Y = 
    {OrElse
     fun {$}
        X:=1
        false
     end
     fun {$}
        X:=2
        false
     end
    }
   {Browse @X}
   {Browse Y}
end

declare
fun {Sum1 N}
   if N==0 then 0 else N + {Sum1 N-1} end
end
declare
fun {Sum2 N S}
   if N==0 then S else {Sum2 N-1 N+S} end
end

{Browse {Sum1 10}}
{Browse {Sum2 10 0}}

%try
%   {Browse {Sum1 10000000}}
%catch X then
%   {Browse X}
%end
{Browse {Sum2 100000000 0}}

declare
fun {SMerge Xs Ys}
   case Xs#Ys
   of nil#Ys then Ys
   [] Xs#nil then Xs
   [] (X|Xr)#(Y|Yr) then
      if X =< Y then X|{SMerge Xr Ys}
      else Y|{SMerge Xs Yr} end
   end
end

{Browse {SMerge [1 5 6] [2 4 7]}}

% https://github.com/Altech/ctmcp-answers/blob/master/Section02/exer10.oz

declare
fun {IsEven X}
   if X==0 then true else {IsOdd X-1} end
end

declare
fun {IsOdd X}
   if X==0 then false else {IsEven X-1} end
end

{Browse {IsEven 9}}
{Browse {IsEven 10}}

% https://github.com/Altech/ctmcp-answers/blob/master/Section02/exer12.oz

declare X Y Z W
X = [a Z]
Y = [W b]
X = Y
{Browse X#Y#Z#W}

{Browse '#'(1 2 3)}
