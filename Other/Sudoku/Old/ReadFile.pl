read_file(File, Chars) :-
    current_input(Old),
    open(File, read, Stream),
    set_input(Stream),
    read_chars(Chars),
    close(Stream),
    set_input(Old),
    !.

/*
read_file('ReadFile.pl', Chars), write(Chars), fail.
read_file('sudoku.txt', Chars), write(Chars), fail.
*/

read_chars(Chars) :-
    get_char(Char),
    read_chars2(Char, [], Chars0),
    reverse(Chars0, Chars).

read_chars2(end_of_file, AccChars, AccChars) :- !.
read_chars2(Char, AccChars, Chars) :-
    get_char(NextChar),
    read_chars2(NextChar, [Char|AccChars], Chars).
