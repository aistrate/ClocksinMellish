d(a, b).
d(b, e).
d(b, c).
d(d, e).
d(c, d).
d(e, f).
d(g, e).

hasphone(g).


go(X, X, T, R) :- reverse(T, R).
go(X, Y, T, P) :-
    (d(X, Z); d(Z, X)),
    \+ member(Z, T),
    go(Z, Y, [Z|T], P).


find_phone(S, X, P) :-
    go(S, X, [S], P),
    hasphone(X).


% find_phone(a, X, P).
