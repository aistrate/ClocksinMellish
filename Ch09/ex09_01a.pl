% should be tested with myconsult.pl

add_two_args(Pred, A1, A2, NewPred) :-
    Pred =.. L1,
    append(L1, [A1, A2], L2),
    NewPred =.. L2.


translate(Head --> Body, Clause) :-
    (Body = [_|_]; Body = []), !,
    append(Body, S, S0),
    add_two_args(Head, S0, S, Clause).

translate(Head --> Body, Clause) :-
    translate_body(Body, NewBody, S0, S),
    add_two_args(Head, S0, S, NewHead),
    Clause = (NewHead :- NewBody).

translate_body(','(First, Rest), NewBody, S0, S) :-
    !,
    add_two_args(First, S0, S1, NewFirst),
    translate_body(Rest, NewRest, S1, S),
    NewBody = (NewFirst, NewRest).
translate_body(Last, NewBody, S0, S) :-
    add_two_args(Last, S0, S, NewBody).


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
