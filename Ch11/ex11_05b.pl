?- [ex11_05a].


concordance_list(List, CL) :-
    concordance_list(case_insensitive, List, CL).

concordance_list(case_insensitive, List, CL) :-
    !,
    maplist(atom_to_lower, List, List1),
    concordance_list(case_sensitive, List1, CL).
concordance_list(case_sensitive, List, CL) :-
    msort(List, Sorted),
    group(Sorted, Grouped),
    maplist(mkpair, Grouped, CL).

mkpair(L, LL - H) :-
    length(L, LL),
    L = [H|_].


% Grouping
group([], []) :- !.
group([H|T], Groups) :- 
    group2(H, [H], T, [], Groups1),
    reverse(Groups1, Groups).

group2(_H, G, [], Acc, [G|Acc]) :- !.
group2(H, G, [H|Rest], Acc, Groups) :-
    !,
    group2(H, [H|G], Rest, Acc, Groups).
group2(_H, G, [Other|Rest], Acc, Groups) :-
    group2(Other, [Other], Rest, [G|Acc], Groups).


% Case sensitivity
atom_to_lower(U, L) :-
    atom_chars(U, UC),
    maplist(upper_to_lower, UC, LC),
    atom_chars(L, LC).

upper_to_lower(U, L) :- char_type(U, to_upper(L)).


% Testing
test_cl(File) :-
    read_file(File, Chars),
    chars_to_words(Chars, Words),
    length(Words, WL), write(WL), write(' individual words.'), nl,
    concordance_list(case_insensitive, Words, CL),
    length(CL, L), write(L), write(' distinct words.'), nl,
    print_list(CL).

print_list(L) :- write('['), print_list2(L), nl.
print_list2([]) :- !, write(']').
print_list2([X]) :- !, write(X), write(']').
print_list2([H|T]) :- write(H), write(', '), print_list2(T).

/*
print_list([]).
print_list([a]).
print_list([a, b, c]).
*/
