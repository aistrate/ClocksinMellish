sudoku(P, P) :- \+ has_zero(P), !.
sudoku(P, S) :-
    subst_var(P, S1, X),
    between(1, 9, X),
    check(S1),
    sudoku(S1, S).


subst_var([L|Ls], [S|Ls], X) :-
    line_has_zero(L),
    !,
    subst_var_in_line(L, S, X).
subst_var([L|Ls], [L|Ss], X) :-
    subst_var(Ls, Ss, X).

subst_var_in_line([0|Cs], [X|Cs], X) :- !.
subst_var_in_line([N|Cs], [N|Rs], X) :-
    subst_var_in_line(Cs, Rs, X).


has_zero([L|_]) :- line_has_zero(L), !.
has_zero([_|Ls]) :- has_zero(Ls).

line_has_zero(L) :- member(0, L), !.


check(P) :-
    get_rows(P, Rows), check_groups(Rows),
    get_cols(P, Cols), check_groups(Cols),
    get_boxes(P, Boxes), check_groups(Boxes).


get_rows(P, P).


get_cols([[]|_], []) :- !.
get_cols(P, [Heads|Cols]) :-
    heads(P, Heads, Tails),
    get_cols(Tails, Cols).

heads([], [], []) :- !.
heads([[H|T]|Rest], [H|Heads], [T|Tails]) :-
    heads(Rest, Heads, Tails).


get_boxes(P, Boxes) :-
    maplist(split_in_threes, P, P1),
    split_in_threes(P1, P2),
    maplist(get_cols, P2, P3),
    split_in_threes(P4, P3),
    maplist(split_in_threes, Boxes, P4),
    !.

split_in_threes([A1, A2, A3, A4, A5, A6, A7, A8, A9], [[A1, A2, A3], [A4, A5, A6], [A7, A8, A9]]).


check_groups(Gs) :- all(check_group, Gs).

% A group is a row, column, or box
check_group(G) :-
    include('<'(0), G, G1),
    is_set(G1).

all(_, []) :- !.
all(Cond, [H|T]) :-
    call(Cond, H),
    all(Cond, T).
