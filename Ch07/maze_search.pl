d(a, b).
d(b, e).
d(b, c).
d(d, e).
d(c, d).
d(e, f).
d(g, e).

hasphone(g).


go(X, X, _).
go(X, Y, T) :-
    (d(X, Z); d(Z, X)),
    \+ member(Z, T),
    go(Z, Y, [Z|T]).


find_phone(S, X) :- go(S, X, []), hasphone(X).
