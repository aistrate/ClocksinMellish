?- [sudoku].


solve(File) :-
    read_file_lines(File, Lines),
    phrase(puzzles(Ps), Lines, []),
    maplist(process_puzzle, Ps, _Sols),
    fail.

/*
solve('sudoku1.txt').
*/


process_puzzle(p(H, P), Sol) :-
    write(H), nl,
    print_puzzle(P), nl,
    sudoku(P, Sol),
    print_puzzle(Sol), nl, nl.


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


format_list(Start, End, Sep, L, F) :- format_list2(Start, End, Sep, L, F1), append(Start, F1, F).
format_list2(_Start, End, _Sep, [], End) :- !.
format_list2(_Start, End, _Sep, [X], F) :- !, append(X, End, F).
format_list2(Start, End, Sep, [H|T], F) :- append(H, Sep, F1), format_list2(Start, End, Sep, T, F2), append(F1, F2, F).

list_to_string(L, S) :- string_to_list(S, L).
