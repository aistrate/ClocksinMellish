sudoku(P, S) :-
    subst_var(P, S1, X, Coords),
    !,
    allowed_choices(P, Coords, L),
    member(X, L),
    sudoku(S1, S).
sudoku(P, P).


subst_var([L|Ls], [S|Ls], X, c(Row, Col)) :-
    has_zero(L),
    !,
    subst_var_in_line(L, S, X, c(Row, Col)).
subst_var([L|Ls], [L|Ss], X, c(Row1, Col)) :-
    subst_var(Ls, Ss, X, c(Row, Col)),
    Row1 is Row + 1.

subst_var_in_line([0|Cs], [X|Cs], X, c(1, 1)) :- !.
subst_var_in_line([N|Cs], [N|Rs], X, c(Row, Col1)) :-
    subst_var_in_line(Cs, Rs, X, c(Row, Col)),
    Col1 is Col + 1.

has_zero(L) :- member(0, L), !.


allowed_choices(P, c(RowIx, ColIx), L) :-
    numlist(1, 9, L1),
    get_rows(P, Rows), nth(RowIx, Rows, Row), subtract2(L1, Row, L2),
    get_cols(P, Cols), nth(ColIx, Cols, Col), subtract2(L2, Col, L3),
    get_box_ix(RowIx, ColIx, BoxIx),
    get_boxes(P, Boxes), nth(BoxIx, Boxes, Box), subtract2(L3, Box, L).

nth(1, [H|_], H) :- !.
nth(N, [_|T], E) :-
    N1 is N - 1,
    nth(N1, T, E).

subtract2(L1, L2, L3) :-
    subtract(L1, L2, L3),
    L3 \== [].


get_box_ix(RowIx, ColIx, BoxIx) :-
    R1 is ((RowIx - 1) // 3) + 1,
    C1 is ((ColIx - 1) // 3) + 1,
    BoxIx is (3 * (R1 - 1)) + C1.


get_rows(P, P).


get_cols([[]|_], []) :- !.
get_cols(P, [Heads|Cols]) :-
    heads(P, Heads, Tails),
    get_cols(Tails, Cols).

heads([], [], []) :- !.
heads([[H|T]|Rest], [H|Heads], [T|Tails]) :-
    heads(Rest, Heads, Tails).


get_boxes(P, Boxes) :-
    maplist(split_threes, P, P1),
    split_threes(P1, P2),
    maplist(get_cols, P2, P3),
    split_threes(P4, P3),
    maplist(split_threes, Boxes, P4),
    !.

split_threes([A1, A2, A3, A4, A5, A6, A7, A8, A9], [[A1, A2, A3], [A4, A5, A6], [A7, A8, A9]]).
