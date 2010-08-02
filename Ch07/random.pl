printlist(X) :- member(E, X), write(E), write(' '), fail.
printlist(_) :- nl.


randomlist(0, []) :- !.
randomlist(N, [X|L]) :-
    random(0, 10, X),
    N1 is N - 1,
    randomlist(N1, L).


countelem(_, [], 0) :- !.
countelem(X, [X|L], N) :-
    !,
    countelem(X, L, N1),
    N is N1 + 1.
countelem(X, [_|L], N) :-
    countelem(X, L, N).


countall(L, C) :-
    numlist(0, 9, Ns),
    countallx(Ns, L, C).

countallx([], _L, []) :- !.
countallx([D|R], L, [C|C1]) :-
    countelem(D, L, N),
    C = cnt(D, N),
    countallx(R, L, C1).


/*
randomlist(1000, L), countall(L, C), printlist(C), fail.
*/
