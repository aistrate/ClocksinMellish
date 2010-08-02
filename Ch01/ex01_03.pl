male(albert).
male(edward).
male(great_albert).
male(little_edward).

female(alice).
female(victoria).

father(great_albert, albert).
father(albert, edward).
father(albert, alice).
father(edward, little_edward).

mother(victoria, edward).
mother(victoria, alice).

parent(X, Y) :- father(X, Y).
parent(X, Y) :- mother(X, Y).


is_father(X) :- father(X, _).
is_mother(X) :- mother(X, _).

is_son(X) :- male(X), parent(_, X).

sibling(X, Y) :-
    dif(X, Y),
    mother(M, X),
    mother(M, Y),
    father(F, X),
    father(F, Y).

sister_of(X, Y) :-
    female(X),
    sibling(X, Y).

grandpa_of(X, Y) :-
    male(X),
    parent(X, Z),
    parent(Z, Y).


/*
half_sister_of(X, Y) :-
    female(X),
    dif(X, Y),
    mother(M, X),
    mother(M, Y),
    father(F1, X),
    father(F2, Y),
    dif(F1, F2).

half_sister_of(X, Y) :-
    female(X),
    dif(X, Y),
    mother(M1, X),
    mother(M2, Y),
    dif(M1, M2),
    father(F, X),
    father(F, Y).
*/
