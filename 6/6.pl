solveCryptarithm([H1|T1],[H2|T2],Sum) :-
    operandAlign([H1|T1],[H2|T2],Sum,AddTop,AddPad,Carry,TSum,Pool),
    solveCryptarithmAux(H1,H2,AddTop,AddPad,Carry,TSum,Pool).

operandAlign(Add1,Add2,Sum,AddTop,AddPad,Carry,TSum,Pool) :-
    operandSwapPad(Add1,Add2,Length,AddTop,AddPad),
    length(Sum,Size),
    (   Size = Length
     -> ( Carry = 0, Sum = TSum , Pool = [1|Peel] )
     ;  ( Size is Length+1, Carry = 1, Sum = [Carry|TSum], Pool = Peel )
    ),
    Peel = [2,3,4,5,6,7,8,9,0].

operandSwapPad(List1,List2,Length,Longer,Padded) :-
    length(List1,Length1),
    length(List2,Length2),
    (   Length1 >= Length2
     -> ( Length = Length1, Longer = List1, Shorter = List2, Pad is Length1 - Length2 )
     ;  ( Length = Length2, Longer = List2, Shorter = List1, Pad is Length2 - Length1 )
    ),
    zeroPad(Shorter,Pad,Padded).

zeroPad(L,0,L).
zeroPad(L,K,P) :-
    K > 0,
    M is K-1,
    zeroPad([0|L],M,P).

solveCryptarithmAux(_,_,[],[],0,[],_).
solveCryptarithmAux(NZ1,NZ2,[H1|T1],[H2|T2],CarryOut,[H3|T3],Pool) :-
    ( CarryIn = 0 ; CarryIn = 1 ),   /* anticipatory carry */
    (   var(H1)
     -> select(H1,Pool,P_ol)
     ;  Pool = P_ol
    ),
    (   var(H2)
     -> select(H2,P_ol,P__l)
     ;  P_ol = P__l
    ),
    (   var(H3)
     -> ( H3 is H1 + H2 + CarryIn - 10*CarryOut, select(H3,P__l,P___) )
     ;  ( H3 is H1 + H2 + CarryIn - 10*CarryOut, P__l = P___ )
    ),
    NZ1 \== 0,
    NZ2 \== 0,
    solveCryptarithmAux(NZ1,NZ2,T1,T2,CarryIn,T3,P___).

%solveCryptarithm([G,I,V,E],[M,O,R,E],[M,O,N,E,Y])