printlist(X) :- member(E, X), write(E), write(' '), fail.
printlist(_) :- nl.


is_integer(0).
is_integer(X) :- is_integer(Y), X is Y + 1.


pythag(X, Y, Z) :-
    intriple(X, Y, Z),
    X > 0, Y > 0, Z > 0,
    X < Y,
    Sumsq is X*X + Y*Y, Sumsq is Z*Z.

intriple(X, Y, Z) :-
    is_integer(Sum),
    minus(Sum, X, Sum1), minus(Sum1, Y, Z).

minus(Sum, Sum, 0).
minus(Sum, D1, D2) :-
    Sum > 0, Sum1 is Sum - 1,
    minus(Sum1, D1, D3), D2 is D3 + 1.


% intriple(X, Y, Z), write(p(X, Y, Z)), nl, S is X + Y + Z, S > 5, !, fail.

% pythag(X, Y, Z), write(p(X, Y, Z)), nl, S is X + Y + Z, S >= 200, !, fail.

% findall(p(X, Y, Z), (pythag(X, Y, Z), S is X + Y + Z, (S =< 200; S > 200, !, fail)), L), printlist(L), length(L, Len), nl, write(Len), fail.
