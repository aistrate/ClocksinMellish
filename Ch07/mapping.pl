printlist(X) :- member(E, X), write(E), write(' '), fail.
printlist(_) :- nl.


maplist(_, [], []).
maplist(P, [X|L], [Y|M]) :-
    Q =.. [P, X, Y], call(Q), maplist(P, L, M).


square(X, Y) :- Y is X^2.

testmap :- numlist(1, 100, L), maplist(square, L, M), printlist(M), fail.


applist(_, []).
applist(P, [X|L]) :-
    Q =.. [P, X], call(Q), applist(P, L).


phh(List) :- applist(write_space, List).

write_space(X) :- write(X), write(', ').


testmap2 :- numlist(1, 100, L), maplist(square, L, M), phh(M), fail.
