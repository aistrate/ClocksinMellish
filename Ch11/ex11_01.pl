flatten(X, [X]) :- \+ islist(X), !.
flatten([], []).
flatten([H|T], L) :-
    flatten(H, H1),
    flatten(T, T1),
    append(H1, T1, L).

islist([]).
islist([_|_]).


flatten0(X, X) :- \+ islist(X), !.
flatten0(X, L) :- flatten(X, L).


/*
flatten([a, [b, c], [[d], [], e]], [a, b, c, d, e]).
flatten([a, [b, c], [[d], [], e]], X).
*/
