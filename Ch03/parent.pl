parent(X, Y) :- child(Y, X).
child(A, B) :- parent(B, A).


/*
mother(adam, mary).

person(adam).
person(mary).
person(X) :- person(Y), mother(X, Y).
*/


person(X) :- person(Y), mother(X, Y).
person(adam).


islist([A|B]) :- islist(B).
islist([]).

weak_islist([]).
weak_islist([_|_]).
