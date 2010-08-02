% should be tested with myconsult.pl

translate(Head --> Body, (NewHead :- NewBody)) :-
    conj2list(Body, BodyList),
    translate2(Head, BodyList, NewHead, NewBodyList),
    list2conj(NewBodyList, NewBody).

translate2(Head, [First|Rest], NewHead, NewRest) :-
    (First = [_|_]; First = []),
    !,
    append(First, S1, S0),
    add_two_args(Head, S0, S, NewHead),
    translate_body(Rest, NewRest, S1, S).
translate2(Head, BodyList, NewHead, NewBodyList) :-
    add_two_args(Head, S0, S, NewHead),
    translate_body(BodyList, NewBodyList, S0, S).

translate_body([], [], S, S).
translate_body([First|Rest], [NewFirst|NewRest], S0, S) :-
    (First = [_|_]; First = []),
    !,
    append(First, S1, S2),      % [orange, mango|S1] = S2
    NewFirst = (S0 = S2),       % S0 = First ++ S1
    translate_body(Rest, NewRest, S1, S).
translate_body([First|Rest], [NewFirst|NewRest], S0, S) :-
    add_two_args(First, S0, S1, NewFirst),
    translate_body(Rest, NewRest, S1, S).


% Helpers
conj2list(','(First, Rest), [First|L]) :-
    !, conj2list(Rest, L).
conj2list(Last, [Last]).

list2conj([], true).
list2conj([C], C) :- !.
list2conj([H|T], (H, L)) :- list2conj(T, L).

add_two_args(Pred, A1, A2, NewPred) :-
    Pred =.. L1,
    append(L1, [A1, A2], L2),
    NewPred =.. L2.


% Testing
write_numvar(X) :-
    numbervars(X, 0, _), write_term(X, [numbervars(true)]).

/*
translate((rrr1 --> [apple, orange]), C), write_numvar(C).
translate((rrr2 --> []), C), write_numvar(C).
translate((rrr3(X, Y) --> [apple]), C), write_numvar(C).
translate((rrr4(X) --> [apple], stuff), C), write_numvar(C).
translate((rrr5(X) --> stuff, [apple]), C), write_numvar(C).
translate((rrr6(X) --> [apple], [orange, mango], stuff(X)), C), write_numvar(C).

rrr1([apple, orange|A], A).
rrr2(A, A).
rrr3(X, Y, [apple|A], A).
rrr4(X, [apple|A], B) :-
	stuff(A, B).
rrr5(X, A, C) :-
	stuff(A, B),
	B=[apple|C].
rrr6(B, [apple|A], D) :-
	A=[orange, mango|C],
	stuff(B, C, D).
*/
