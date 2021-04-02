money_puzzle(A, B, C) :-
    maplist(reverse, [A,B,C], [X,Y,Z]),
    numlist(0, 9, Dom),
    solve(0, Dom, X,Y,Z),
    A \= [0|_], B \= [0|_].

solve(C, D0, [X|Xs], [Y|Ys], [Z|Zs]) :-
    peek(D0, X, D1),
    peek(D1, Y, D2),
    peek(D2, Z, D3),
    S is X+Y+C,
    ( S > 9 -> Z is S - 10, C1 = 1 ; Z = S, C1 = 0 ),
    solve(C1, D3, Xs, Ys, Zs).
solve(C, D0, [], [Y|Ys], [Z|Zs]) :-
    peek(D0, Y, D1),
    peek(D1, Z, D2),
    S is Y+C,
    ( S > 9 -> Z is S - 10, C1 = 1 ; Z = S, C1 = 0 ),
    solve(C1, D2, [], Ys, Zs).
solve(0, _, [], [], []).
solve(1, _, [], [], [1]).

peek(D, V, R) :- var(V) -> select(V, D, R) ; R = D.