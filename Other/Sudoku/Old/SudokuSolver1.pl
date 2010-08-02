[readfile].

puzzles([p(H, B)|Ps]) --> puzzle(H, B), !, puzzles(Ps).
puzzles([]) --> !.

puzzle(H, B) --> header(H), body(B).

% header(H) --> ['G', 'r', 'i', 'd', ' '], line(Cs), { atom_chars(A, Cs), number(A), number_chars(N, Cs)


line(L) --> new_line, line_chars(L).

new_line --> [C], {is_end_of_line(C)}, !, new_line.
new_line --> !.

line_chars([C|L]) --> [C], {\+ is_end_of_line(C)}, !, line_chars2(L).
line_chars2([C|L]) --> [C], {\+ is_end_of_line(C)}, !, line_chars2(L).
line_chars2([]) --> !.

is_end_of_line('\n').
is_end_of_line('\r').

/*
read_file('sudoku.txt', Chars), phrase(line(L1), Chars, Chars1), phrase(line(L2), Chars1, Chars2).
*/
