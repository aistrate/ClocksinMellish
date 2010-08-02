% should be tested with myconsult.pl

translate(H --> L, Clause) :-
    (L = [_|_]; L = []), !,
    H =.. L1,
    append(L, X, Y),
    append(L1, [Y, X], L2),
    Clause =.. L2.

translate(Head --> Body, Clause) :-
    translate_body(Body, NewBody, S0, S),
    Head =.. L1,
    append(L1, [S0, S], L2),
    NewHead =.. L2,
    Clause = (NewHead :- NewBody).

translate_body(','(First, Rest), NewBody, S0, S) :-
    !,
    First =.. L1,
    append(L1, [S0, S1], L2),
    NewFirst =.. L2,
    translate_body(Rest, NewRest, S1, S),
    NewBody = (NewFirst, NewRest).
translate_body(Last, NewBody, S0, S) :-
    Last =.. L1,
    append(L1, [S0, S], L2),
    NewBody =.. L2.


/*
rrr --> [apple, orange].
rrr([apple, orange|A], A).

rrr2 --> [].
rrr2(A, A).

rrr3(X, Y) --> [apple].
rrr3(_, _, [apple|A], A).

rrr4(X) --> [apple], stuff.
rrr4(_, [apple|A], B) :-
	stuff(A, B).

rrr5(X) --> stuff, [apple].
rrr5(_, A, C) :-
	stuff(A, B),
	B=[apple|C].
*/
