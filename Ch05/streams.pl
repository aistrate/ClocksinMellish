programRead :-
    open('ex05_02.pl', read, X),
    current_input(Stream),
    set_input(X),
    programWrite,
    close(X),
    set_input(Stream).


programWrite :-
    open('output.txt', write, Y),
    current_output(StreamO),
    set_output(Y),
    code_copy,
    close(Y),
    set_output(StreamO).


code_copy :-
    repeat,
    read_line(X), 
    write_line(X), nl, 
    X = [end_of_file], !.


read_line(X) :- get_char(C), read_line_x(C, X).

read_line_x(end_of_file, [end_of_file]) :- !.
read_line_x('\n', []) :- !.
read_line_x(C, [C|X]) :- get_char(C1), read_line_x(C1, X).


write_line([end_of_file|_]) :- !.
write_line(X) :- string_to_list(S, X), write(S).
