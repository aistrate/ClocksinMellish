?- [sudoku].


solve(File) :-
    read_file_lines(File, Lines),
    phrase(puzzles(Ps), Lines, []),
    maplist(process_puzzle, Ps, _Sols).
    % !.

/*
solve('sudoku1.txt').
*/


/*
process_puzzle(p(H, P), Sol) :-
    write(H), nl,
    print_puzzle(P), nl,
    puzzle_n_to_s(P, PS),
    sudoku(PS, SolS),
    print_puzzle_struct(SolS), nl, nl.
    % puzzle_n_to_s(Sol, SolS),
    % print_puzzle(Sol).
*/

process_puzzle(p(H, P), Sol) :-
    write(H), nl,
    print_puzzle(P), nl,
    sudoku(P, Sol),
    print_puzzle(Sol), nl, nl.


print_puzzle_struct(S) :-
    print_puzzle(S, format_struct).

format_struct(S, F) :- term_to_atom(S, A), atom_codes(A, F).


puzzle_n_to_s(Num, Struct) :- maplist(maplist(num_to_struct), Num, Struct).

num_to_struct(0, empt) :- !.    % empty cell
num_to_struct(N, f(N)) :- !.    % fixed cell
num_to_struct(N, t(N)) :- !.    % try cell
num_to_struct(0, c(_)).        % choice cell


read_file_lines(File, Lines) :-
    open(File, read, Stream),
    read_lines(Stream, Lines),
    close(Stream),
    !.

read_lines(Stream, [Line|Lines]) :-
    read_line_to_codes(Stream, Line),
    \+ Line = end_of_file,
    read_lines(Stream, Lines).
read_lines(_, []).

/*
read_file_lines('sudoku.txt', Lines), length(Lines, L), write(L), fail.
read_file_lines('sudoku1.txt', Lines), length(Lines, L).
*/


puzzles([p(H, B)|Ps]) --> puzzle(H, B), !, puzzles(Ps).
puzzles([]) --> !.

puzzle(H, B) --> header(H), body(B).

header(H) --> [L], {atom_codes(H, L)}.

body(B) --> lines(9, Ls), {maplist(maplist(code_to_num), Ls, B)}.

code_to_num(C, N) :- number_codes(N, [C]).

lines(0, []) --> !.
lines(N, [L|Ls]) --> [L], {N1 is N - 1}, lines(N1, Ls).


print_puzzle(P) :- print_puzzle(P, number_codes).

print_puzzle(P, Format_Cell) :-
    maplist(maplist(Format_Cell), P, F1),
    maplist(format_list("[", "]", ", "), F1, F2),
    format_list("", "", "\n", F2, F3),
    string_to_list(F, F3),
    write(F), nl.

/*
read_file_lines('sudoku1.txt', Lines), phrase(puzzles(Ps), Lines, []), Ps = [p(_, P)|_], print_puzzle(P), fail.
*/


format_list(Start, End, Sep, L, F) :- format_list2(Start, End, Sep, L, F1), append(Start, F1, F).
format_list2(_Start, End, _Sep, [], End) :- !.
format_list2(_Start, End, _Sep, [X], F) :- !, append(X, End, F).
format_list2(Start, End, Sep, [H|T], F) :- append(H, Sep, F1), format_list2(Start, End, Sep, T, F2), append(F1, F2, F).

list_to_string(L, S) :- string_to_list(S, L).

/*
numlist(1, 20, L), maplist(number_codes, L, L1), maplist(list_to_string, L1, L2).
numlist(1, 20, L), maplist(number_codes, L, L1), format_list("[", "]", ", ", L1, F), string_to_list(S, F), write(S), fail.
*/
