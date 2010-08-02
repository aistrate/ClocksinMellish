list1(X) :- \+ clause(X, _), !, fail.
list1(X) :-
    clause(X, Y),
    output_clause(X, Y), write('.'), nl, fail.
list1(_X).

output_clause(X, true) :- !, replace_vars(X, R), write(R).
output_clause(X, Y) :- replace_vars((X :- Y), R), write(R).


replace_vars(C, R) :- repl_vars(C, R, [], _Map).

repl_vars(X, V, OldMap, NewMap) :- 
    var(X), 
    !,
    term_to_atom(X, A),
    find_map(A, V, OldMap, NewMap).
repl_vars(X, X, Map, Map) :- atomic(X), !.
repl_vars(X, Y, OldMap, NewMap) :-
    X =.. [P|Args],
    repl_vars_list(Args, Args1, OldMap, NewMap),
    Y =.. [P|Args1].

repl_vars_list([], [], Map, Map).
repl_vars_list([H|T], [H1|T1], OldMap, NewMap) :-
    repl_vars(H, H1, OldMap, NewMap1),
    repl_vars_list(T, T1, NewMap1, NewMap).


find_map(X, V, OldMap, OldMap) :-
    member(m(X, V), OldMap), !.
find_map(X, V, [], [m(X, V)]) :- !, V = 'A'.
find_map(X, V, OldMap, NewMap) :-
    OldMap = [m(_, V1)|_],
    atom_chars(V1, C1),
    next_name(C1, C),
    atom_chars(V, C),
    NewMap = [m(X, V)|OldMap].


next_name(['Z'], ['A', '1']) :- !.
next_name(['Z'|Digits], ['A'|Digits1]) :-
    !,
    number_chars(N, Digits),
    N1 is N + 1,
    number_chars(N1, Digits1).
next_name([L|Digits], [L1|Digits]) :-
    char_code(L, C),
    C1 is C + 1,
    char_code(L1, C1).


/*
next_name(['A'], X).
next_name(['D'], X).
next_name(['X'], X).
next_name(['Z'], X).
next_name(['A', '1'], X).
next_name(['K', '2'], X).
next_name(['Z', '5'], X).
next_name(['F', '9', '9', '9'], X).
next_name(['Z', '9', '9', '9'], X).
*/


varlist(0, []) :- !.
varlist(N, [_|X]) :-
    N1 is N - 1,
    varlist(N1, X).

test_numbervars(N) :-
    varlist(N, X), 
    numbervars(X, 0, _), 
    write_term(X, [numbervars(true)]), 
    fail.
