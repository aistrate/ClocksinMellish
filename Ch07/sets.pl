setmember(X, [X|_]).
setmember(X, [_|Y]) :- setmember(X, Y).

mysubset([], _Y).
% mysubset([A|X], Y) :- setmember(A, Y), mysubset(X, Y).
mysubset([A|X], Y) :- setmember(A, Y), delete(Y, A, Z), mysubset(X, Z).

/*
findall(X, mysubset(X, [a, b, c, d]), Sols), member(S, Sols), write(S), nl, fail.
findall(X, mysubset(X, [a, b, c, d]), Sols), length(Sols, L).
*/

myintersection([], _X, []).
myintersection([X|R], Y, [X|Z]) :-
    setmember(X, Y),
    !,
    myintersection(R, Y, Z).
myintersection([_X|R], Y, Z) :- myintersection(R, Y, Z).

myunion([], A, A).
myunion([A|C], B, D) :- setmember(A, B), !, myunion(C, B, D).
myunion([A|B], C, [A|D]) :- myunion(B, C, D).
