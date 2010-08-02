% random
:- dynamic seed/1.

seed(13).

myrandom(R, N) :-
    retract(seed(S)),
    N is (S mod R) + 1,
    NewSeed is (125 * S + 1) mod 4096,
    asserta(seed(NewSeed)), !.

testrandom :- repeat, myrandom(10, X), write(X), nl, X = 5, !.


% gensym
:- dynamic current_num/2.

mygensym(Root, Atom) :-
    get_num(Root, Num),
    atom_chars(Root, Name1),
    number_chars(Num, Name2),
    append(Name1, Name2, Name),
    atom_chars(Atom, Name).

get_num(Root, Num) :-
    retract(current_num(Root, Num1)), !,
    Num is Num1 + 1,
    asserta(current_num(Root, Num)).
get_num(Root, 1) :- assert(current_num(Root, 1)).


parents(edward, victoria, albert).
parents(alice, victoria, albert).


% findall
:- dynamic found/1.

myfindall(X, G, _) :-
    asserta(found(mark)),
    call(G),
    asserta(found(result(X))),
    fail.
myfindall(_, _, L) :- collect_found([], M), !, L = M.

collect_found(S, L) :-
    getnext(X),
    !,
    collect_found([X|S], L).
collect_found(L, L).

getnext(Y) :- retract(found(X)), !, X = result(Y).
