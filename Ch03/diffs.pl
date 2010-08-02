/* p(X, Y) :- append(X, X, Y). */

/* p(X, Y) :- append(Y, Y, X). */

p(Hole, Hole).

p([d|NewHole], NewHole).
