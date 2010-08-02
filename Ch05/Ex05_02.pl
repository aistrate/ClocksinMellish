correct_line :-
    get_char(X),
    correct_rest_line('\n', X).

correct_rest_line(C, '\n') :- !,
    replace(C, C1),
    put_char(C1), nl.

correct_rest_line(Last, Current) :-
    typing_error(Last, Current, Corr), !,
    get_char(New),
    correct_rest_line(Corr, New).

correct_rest_line(Last, Current) :-
    replace(Last, Last1),
    put_char(Last1),
    get_char(New),
    correct_rest_line(Current, New).

typing_error('q', 'w', 'q').
typing_error('c', 'v', 'c').


replace(a, b) :- !.
replace(C, C).

read_lines :-
    correct_line,
    read_lines.
