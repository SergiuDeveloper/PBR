member(house(_, _, german, _, _, fish), _Problem).
member(house(_, red, brit, _, _, _), _Problem).
member(house(_, _, swede, _, _, dogs), _Problem).
member(house(_, _, dane, tea, _, _), _Problem).
member(house(_, green, _, coffee, _, _), _Problem).
member(house(_, _, _, _, pallmall, birds), _Problem).
member(house(_, yellow, _, _, dunhill, _), _Problem).
member(house(3, _, _, milk, _, _), _Problem).
member(house(1, _, norwegian, _, _, _), _Problem).
member(house(_, _, _, beer, bluemaster, _), _Problem).
member(house(_, _, german, _, prince, _), _Problem).

member(house(_A, green, _, _, _, _), _Problem).
member(house(_B, white, _, _, _, _), _Problem).

member(house(_C, _, _, _, blends, _), _Problem).
member(house(_D, _, _, _, _, cats), _Problem).

member(house(_E, _, _, _, _, horses), _Problem).
member(house(_F, _, _, _, dunhill, _), _Problem).

member(house(_G, _, norwegian, _, _, _), _Problem).
member(house(_H, blue, _, _, _, _), _Problem).

member(house(_I, _, _, _, blend, _), _Problem).
member(house(_J, _, _, water, _, _), _Problem).

left_of(X, Y) :- X @< Y.
left_of(_A, _B).

next_to(X, Y) :- X @> Y.
next_to(_C, _D).
next_to(_E, _F).
next_to(_G, _H).

neighbor(X, Y) :- left_of(X, Y) ; next_to(X, Y).
neighbor(_I, _J).

listlen([], 0).
listlen([H|T], Len) :-
	(H = [_|_] -> listlen(H, TLen) ; HLen = 1),
	(T = [_|_] -> listlen(T, TLen); TLen = 1),
	Len is HLen + TLen.

/*
_Problem = [
	house(1, _Color1, _Nationality1, _Beverage1, _Cigarettes1, _Pets1),
	house(2, _Color2, _Nationality2, _Beverage2, _Cigarettes2, _Pets2),
	house(3, _Color3, _Nationality3, _Beverage3, _Cigarettes3, _Pets3),
	house(4, _Color4, _Nationality4, _Beverage4, _Cigarettes4, _Pets4),
	house(5, _Color5, _Nationality5, _Beverage5, _Cigarettes5, _Pets5)
].
*/

/* 1
member(house(_K, _, _, _, _, _), _Problem),
member(house(_L, red, _, _, _, _), _Problem),
next_to(_K, _L),
member(house(_K, _, _, _, _, What), _Problem).
*/

/* 2
findall(house(_K, _, _, _, _, What), member(house(_K, _, _, _, _, What), _Problem), _Solutions),
listlen(_Solutions, _SolutionsLen).
*/