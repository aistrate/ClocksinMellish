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
simp(-E, F) :- simp((-1) * E, F).
simp(log(E), log(F)) :- simp(E, F).
simp(E, F) :-
    E =.. [Op, La, Ra],
    simp(La, X),
    simp(Ra, Y),
    s(Op, X, Y, F).


s(+, X, 0, X) :- !.
s(+, 0, X, X) :- !.

s(-, X, 0, X) :- !.
s(-, 0, X, -X) :- !.

s(*, _, 0, 0) :- !.
s(*, 0, _, 0) :- !.
s(*, 1, X, X) :- !.
s(*, X, 1, X) :- !.
s(*, -1, X, -X) :- !.
s(*, X, -1, -X) :- !.

s(/, 0, X, 0) :- \+ number(X), !.
s(/, 0, X, 0) :- number(X), X =\= 0, !.
s(/, X, 1, X) :- !.

s(^, _X, 0, 1) :- !.
s(^, 0, X, 0) :- \+ number(X), !.
s(^, 0, X, 0) :- number(X), X =\= 0, !.
s(^, X, 1, X) :- !.
s(^, 1, _X, 1) :- !.
s(^, X, C, 1 / (X ^ D)) :- number(C), C < 0, D is -C, !.


s(+, X, Y, Z) :- number(X), number(Y), Z is X + Y, !.
s(+, X + Y, W, X + Z) :- number(Y), number(W), Z is Y + W, !.
s(+, X + Y, W, Y + Z) :- number(X), number(W), Z is X + W, !.

s(-, X, Y, Z) :- number(X), number(Y), Z is X - Y, !.

s(*, X, Y, Z) :- number(X), number(Y), Z is X * Y, !.
s(*, X * Y, W, Z * X) :- number(Y), number(W), Z is Y * W, !.
s(*, X * Y, W, Z * Y) :- number(X), number(W), Z is X * W, !.
s(*, X, Y * W, Z) :- s(*, X, Y, T), s(*, T, W, Z), !.

s(/, X, Y, Z) :- number(X), number(Y), Z is X / Y, !.

s(^, X, Y, Z) :- number(X), number(Y), Z is X ^ Y, !.
s(^, X ^ Y, W, X ^ Z) :- number(Y), number(W), Z is Y * W, !.


s(+, X, Y, X + Y).
s(-, X, Y, X - Y).
s(*, X, Y, X * Y).
s(/, X, Y, X / Y).
s(^, X, Y, X ^ Y).


d_simp(E, X, D) :- d(E, X, D1), simp(D1, D).

print_simp(X) :- simp(X, Y), write(Y), nl, fail.

% d((x^2 + 3) / (2*x + 1), x, Y), print_simp(Y).

% d_simp(-2*x^3 + 5*x^2 - x + 100, x, Y), d_simp(Y, x, Z).
