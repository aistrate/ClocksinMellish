printlist(X) :- member(E, X), write(E), write(' '), fail.
printlist(_) :- nl.


a(g, h).
a(g, d).
a(e, d).
a(h, f).
a(e, f).
a(a, e).
a(a, b).
a(b, f).
a(b, c).
a(f, c).
a(d, a).


go(X, X).
go(X, Y) :- a(X, Z), go(Z, Y).


go(X, X, _T).
go(X, Y, T) :- a(X, Z), legal(Z, T), go(Z, Y, [Z|T]).

legal(_X, []).
legal(X, [H|T]) :- \+ X = H, legal(X, T).


go_undir(X, X, _T).
go_undir(X, Y, T) :- 
    (a(X, Z); a(Z, X)),
    legal(Z, T), 
    go_undir(Z, Y, [Z|T]).
