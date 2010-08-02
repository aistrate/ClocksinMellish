d(X, X, 1) :- !.
d(C, _X, 0) :- atomic(C).
d(-U, X, -A) :- d(U, X, A).
d(U + V, X, A + B) :- d(U, X, A), d(V, X, B).
d(U - V, X, A - B) :- d(U, X, A), d(V, X, B).
d(C * U, X, C * A) :- atomic(C), \+ C = X, d(U, X, A), !.
d(U * V, X, B * U + A * V) :- d(U, X, A), d(V, X, B).
d(U / V, X, A) :- d(U * V^(-1), X, A).
d(U ^ C, X, C * U^(C - 1) * W) :- atomic(C), \+ C = X, d(U, X, W).
d(log(U), X, A * U^(-1)) :- d(U, X, A).


simp(E, E) :- atomic(E), !.
simp(-E, -F) :- simp(E, F).
simp(log(E), log(F)) :- simp(E, F).
simp(E, F) :-
    E =.. [Op, La, Ra],
    simp(La, X),
    simp(Ra, Y),
    s(Op, X, Y, F).


s(+, X, 0, X).
s(+, 0, X, X).
s(+, X, Y, X + Y).

s(-, X, 0, X).
s(-, 0, X, -X).
s(-, X, Y, X - Y).

s(*, _, 0, 0).
s(*, 0, _, 0).
s(*, 1, X, X).
s(*, X, 1, X).
s(*, X, Y, X * Y).

s(/, 0, X, 0) :- \+ number(X).
s(/, 0, X, 0) :- number(X), X =\= 0.
s(/, X, 1, X).
s(/, X, Y, X / Y).

s(^, _X, 0, 1).
s(^, 0, X, 0) :- \+ number(X).
s(^, 0, X, 0) :- number(X), X =\= 0.
s(^, X, 1, X).
s(^, 1, _X, 1).
s(^, X, C, 1 / (X ^ D)) :- number(C), C < 0, D is -C.
s(^, X, Y, X ^ Y).


s(+, X, Y, Z) :- number(X), number(Y), Z is X + Y.
s(+, X + Y, W, X + Z) :- number(Y), number(W), Z is Y + W.
s(+, X + Y, W, Y + Z) :- number(X), number(W), Z is X + W.

s(-, X, Y, Z) :- number(X), number(Y), Z is X - Y.

s(*, X, Y, Z) :- number(X), number(Y), Z is X * Y.
s(*, X * Y, W, Z * X) :- number(Y), number(W), Z is Y * W.
s(*, X * Y, W, Z * Y) :- number(X), number(W), Z is X * W.

s(/, X, Y, Z) :- number(X), number(Y), Z is X / Y.

s(^, X, Y, Z) :- number(X), number(Y), Z is X ^ Y.
s(^, X ^ Y, W, X ^ Z) :- number(Y), number(W), Z is Y * W.


print_simp(X) :- simp(X, Y), write(Y), nl, fail.
