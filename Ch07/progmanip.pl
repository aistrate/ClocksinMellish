% listing
list1(X) :- \+ clause(X, _), !, fail.
list1(X) :-
    clause(X, Y),
    output_clause(X, Y), write('.'), nl, nl, fail.
list1(_X).

output_clause(X, true) :- !, write_clause(X).
output_clause(X, Y) :- write_clause(X :- Y).

write_clause(X) :-
    numbervars(X, 0, _),
    write_term(X, [numbervars(true)]),
    fail.
write_clause(_).


% Prolog interpreter
interpret(true) :- !.
interpret((G1, G2)) :- !, interpret(G1), interpret(G2).
interpret(Goal) :- clause(Goal, MoreGoals), interpret(MoreGoals).


% retractall
myretractall(X) :- retract(X), fail.
myretractall(X) :- retract(X :- _Y), fail.
myretractall(_).

:- dynamic testterm/2.

testterm(a, b).
testterm(c, d).
testterm(A, A).
testterm(A, B) :- testterm(B, A).


% consult
myconsult(File) :-
    retractall(done(_)),
    current_input(Old),
    open(File, read, Stream),
    set_input(Stream),
    repeat,
    read(Term),
    try(Term),
    close(Stream),
    set_input(Old),
    !.

try(end_of_file) :- !.
try(?- Goals) :- !, call(Goals), !, fail.
try(:- _Goals) :- !, fail.
try(Clause) :-
    head(Clause, Head),
    record_done(Head),
    assertz(Clause),
    fail.

:- dynamic done/1.

record_done(Head) :- done(Head), !.
record_done(Head) :-
    functor(Head, Func, Arity),
    functor(Proc, Func, Arity),
    asserta(done(Proc)),
    retractall(Proc),
    !.

head(A :- _B, A) :- !.
head(A, A).

% myconsult('sets.pl').
% myconsult('database.pl').
