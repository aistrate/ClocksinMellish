n_to_s(N, S) :- var(N), var(S), !, fail.
n_to_s(0, zero) :- !.
n_to_s(N, s(S1)) :-
    integer(N), !,
    N > 0,
    N1 is N - 1,
    n_to_s(N1, S1).
n_to_s(N, s(S1)) :-
    var(N), !,
    n_to_s(N1, S1),
    N is N1 + 1.


test_op(Op, X, Y, Z) :-
    n_to_s(X, SX),
    n_to_s(Y, SY),
    P =.. [Op, SX, SY, SZ],
    call(P),
    n_to_s(Z, SZ).

test_op(Op, X, Y, Z, W) :-
    n_to_s(X, SX),
    n_to_s(Y, SY),
    P =.. [Op, SX, SY, SZ, SW],
    call(P),
    n_to_s(Z, SZ),
    n_to_s(W, SW).

test_op(Op, X, Y) :-
    n_to_s(X, SX),
    P =.. [Op, SX, SY],
    call(P),
    n_to_s(Y, SY).

test_pred(Pred, X, Y) :-
    n_to_s(X, SX),
    n_to_s(Y, SY),
    P =.. [Pred, SX, SY],
    call(P).


% Arithmetical ops

s_plus(zero, Y, Y) :- !.
s_plus(s(X1), Y, s(Z1)) :-
    s_plus(X1, Y, Z1).

/*
test_op(s_plus, 5, 7, Z).
test_op(s_plus, 0, 20, Z).
test_op(s_plus, 15, 0, Z).
test_op(s_plus, 5, 1, Z).
test_op(s_plus, 1, 7, Z).
test_op(s_plus, 507, 743, Z).
test_op(s_plus, 25077, 17433, Z).
*/


s_minus(X, Y, Z) :- s_plus(Y, Z, X).

/*
test_op(s_minus, 5, 7, Z).
test_op(s_minus, 7, 5, Z).
test_op(s_minus, 512, 128, Z).
test_op(s_minus, 4, 4, Z).
test_op(s_minus, 5, 4, Z).
test_op(s_minus, 0, 0, Z).
*/


s_mult(zero, _Y, zero) :- !.
s_mult(s(zero), Y, Y) :- !.
s_mult(s(X1), Y, Z) :-
    s_mult(X1, Y, Z1),
    s_plus(Y, Z1, Z).

/*
test_op(s_mult, 5, 7, Z).
test_op(s_mult, 0, 17, Z).
test_op(s_mult, 25, 0, Z).
test_op(s_mult, 1, 53, Z).
test_op(s_mult, 28, 1, Z).
test_op(s_mult, 512, 128, Z).
test_op(s_mult, 15, 77, Z).
*/


s_lessthan(_, zero) :- !, fail.
s_lessthan(zero, _) :- !.
s_lessthan(s(X1), s(Y1)) :-
    s_lessthan(X1, Y1).

/*
test_pred(s_lessthan, 5, 7).
test_pred(s_lessthan, 0, 7).
test_pred(s_lessthan, 0, 1).
test_pred(s_lessthan, 0, 0).
test_pred(s_lessthan, 1, 0).
test_pred(s_lessthan, 3, 0).
test_pred(s_lessthan, 15, 15).
test_pred(s_lessthan, 18, 17).
test_pred(s_lessthan, 2, 1).
test_pred(s_lessthan, 3, 4).
test_pred(s_lessthan, 1, 1).
test_pred(s_lessthan, 1259, 1259).
test_pred(s_lessthan, 1258, 1259).
*/


s_equals(zero, zero) :- !.
s_equals(s(X1), s(Y1)) :-
    s_equals(X1, Y1).

/*
test_pred(s_equals, 5, 7).
test_pred(s_equals, 17, 17).
test_pred(s_equals, 1, 1).
test_pred(s_equals, 0, 0).
test_pred(s_equals, 1, 0).
test_pred(s_equals, 0, 1).
test_pred(s_equals, 11, 10).
*/


s_div(_, zero, _, _) :- !, fail.
s_div(zero, _, zero, zero) :- !.
s_div(X, Y, zero, X) :-
    s_lessthan(X, Y), !.
s_div(X, Y, s(Q1), R) :-
    s_minus(X, Y, Z),
    s_div(Z, Y, Q1, R).

/*
test_op(s_div, 0, 0, Q, R).
test_op(s_div, 5, 0, Q, R).
test_op(s_div, 0, 1, Q, R).
test_op(s_div, 0, 9, Q, R).
test_op(s_div, 4, 1, Q, R).
test_op(s_div, 6, 2, Q, R).
test_op(s_div, 144, 24, Q, R).
test_op(s_div, 145, 24, Q, R).
test_op(s_div, 21, 7, Q, R).
test_op(s_div, 8192, 64, Q, R).
test_op(s_div, 23, 5, Q, R).
test_op(s_div, 7, 14, Q, R).
test_op(s_div, 11, 12, Q, R).
test_op(s_div, 17, 17, Q, R).
test_op(s_div, 10000, 128, Q, R).
*/


s_sqrt(zero, zero) :- !.
s_sqrt(s(zero), s(zero)) :- !.
/*s_sqrt(N, S) :-
    s_is_integer(S),
    s_lessthan(s(zero), S),
    s_div(N, S, Q, R),
    ((s_lessthan(Q, S), !, fail); true),
    s_equals(zero, R),
    s_equals(Q, S),
    !.*/
s_sqrt(N, S) :- s_sqrt2(N, s(s(zero)), S).
s_sqrt2(N, C, S) :-
    s_div(N, C, Q, _R),
    s_lessthan(C, Q),
    !,
    s_sqrt2(N, s(C), S).
s_sqrt2(N, S, S) :-
    s_div(N, S, Q, R),
    s_equals(S, Q),
    !,
    s_equals(zero, R).    


/*
test_op(s_sqrt, 0, S).
test_op(s_sqrt, 1, S).
test_op(s_sqrt, 2, S).
test_op(s_sqrt, 4, S).
test_op(s_sqrt, 9, S).
test_op(s_sqrt, 10, S).
test_op(s_sqrt, 25, S).
test_op(s_sqrt, 1024, S).
test_op(s_sqrt, 10000, S).
test_op(s_sqrt, 9955, S).
test_op(s_sqrt, 15129, S).
*/


s_is_integer(zero).
s_is_integer(s(S1)) :- s_is_integer(S1).

/*
s_is_integer(zero).
s_is_integer(s(zero)).
s_is_integer(s(s(s(s(zero))))).
n_to_s(9, M), s_is_integer(S), write(S), nl, \+ s_lessthan(S, M), !, fail.
*/
