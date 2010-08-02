permute([], []).
permute(L, [H|T]) :-
    append(V, [H|U], L),
    append(V, U, W),
    permute(W, T).
