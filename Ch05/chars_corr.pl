correct_line :-
    get_char(X),
    correct_rest_line('\n', X).

correct_rest_line(C, '\n') :- !,
    put_char(C), nl.

correct_rest_line(Last, Current) :-
    typing_error(Last, Current, Corr), !,
    get_char(New),
    correct_rest_line(Corr, New).

correct_rest_line(Last, Current) :-
    put_char(Last),
    get_char(New),
    correct_rest_line(Current, New).

typing_error('q', 'w', 'q').
typing_error('c', 'v', 'c').
