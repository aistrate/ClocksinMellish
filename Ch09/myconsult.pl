?- consult(ex09_01b).

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
try(H --> B) :- 
    translate(H --> B, Clause), 
    !,
    try(Clause).
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
