printlist(X) :- member(E, X), write(E), write(' '), fail.
printlist(_) :- nl.


is_integer(0).
is_integer(X) :- is_integer(Y), X is Y + 1.


pythag(X, Y, Z) :-
    is_integer(Z),
    Lim is floor(Z / sqrt(2)),
    triplet(1, Lim, X, Y, Z).

triplet(MinX, MaxX, X, Y, Z) :-
    MinX =< MaxX,
    X = MinX,
    Y0 is sqrt(Z^2 - X^2),
    Y is floor(Y0),
    Y =:= Y0.
triplet(MinX, MaxX, X, Y, Z) :-
    MinX =< MaxX,
    MinX2 is MinX + 1,
    triplet(MinX2, MaxX, X, Y, Z).


% findall(p(X, Y, Z), (pythag(X, Y, Z), (Z =< 1000; Z > 1000, !, fail)), L), printlist(L), length(L, Len), nl, write(Len), fail.

% pythag(X, Y, Z), write(p(X, Y, Z)), nl, Z >= 5000, !, fail.
