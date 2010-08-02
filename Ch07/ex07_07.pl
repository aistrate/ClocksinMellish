get_elem(1, [X|_], X) :- !.
get_elem(N, [_|L], X) :-
    N1 is N - 1,
    get_elem(N1, L, X).

random_pick(L, E) :-
    length(L, N),
    N1 is N + 1,
    random(1, N1, I),
    get_elem(I, L, E).
