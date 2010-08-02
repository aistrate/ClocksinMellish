sudoku(P, S) :-
    configuration(P, S),
    check(S).


configuration(P, S) :-
	maplist(maplist(replace_cell), P, C),
	check(S).

replace_cell(0, X) :- !, choice(X).
replace_cell(N, N).

choice(X) :- numlist(1, 9, L), member(X, L).


check(S).


/*
has_zero([]) :- !, fail.
has_zero([0|_]) :- !.
has_zero([_|T]) :- has_zero(T).
*/

subst_var([P|Ps], Cand, X) :-
    has_zero(P),
    !,
    

has_zero(L) :- member(0, L), !.
