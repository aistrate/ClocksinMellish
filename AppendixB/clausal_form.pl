translate(X) :-
    implout(X, X1),             /* Stage 1 */
    negin(X1, X2),              /* Stage 2 */
    skolem(X2, X3, []),         /* Stage 3 */
    univout(X3, X4),            /* Stage 4 */
    conjn(X4, X5),              /* Stage 5 */
    clausify(X5, Clauses, []),  /* Stage 6 */
    pclauses(Clauses).          /* Print out clauses */


:- op(200, fx, ~).
:- op(400, xfy, #).
:- op(400, xfy, &).
:- op(700, xfy, ->).
:- op(700, xfy, <->).


/* Stage 1 - Removing implications */
implout((P <-> Q), ((P1 & Q1) # (~P1 & ~Q1))) :-
    !, implout(P, P1), implout(Q, Q1).
implout((P -> Q), (~P1 # Q1)) :-
    !, implout(P, P1), implout(Q, Q1).
implout(all(X, P), all(X, P1)) :- !, implout(P, P1).
implout(exists(X, P), exists(X, P1)) :- !, implout(P, P1).
implout((P & Q), (P1 & Q1)) :-
    !, implout(P, P1), implout(Q, Q1).
implout((P # Q), (P1 # Q1)) :-
    !, implout(P, P1), implout(Q, Q1).
implout((~P), (~P1)) :- !, implout(P, P1).
implout(P, P).

/*
implout(x <-> y, R).
implout(x -> y, R).
implout(all(x, x -> y), R).
implout(exists(x, x <-> y), R).
implout((x -> y) & (y -> z), R).
implout((x -> y) # (y -> x), R).
implout(~(x -> y), R).
implout(all(x, man(x) -> human(x)), R).
*/


/* Stage 2 - Moving negation inwards */
negin((~P), P1) :- !, neg(P, P1).
negin(all(X, P), all(X, P1)) :- !, negin(P, P1).
negin(exists(X, P), exists(X, P1)) :- !, negin(P, P1).
negin((P & Q), (P1 & Q1)) :-
    !, negin(P, P1), negin(Q, Q1).
negin((P # Q), (P1 # Q1)) :-
    !, negin(P, P1), negin(Q, Q1).
negin(P, P).

neg((~P), P1) :- !, negin(P, P1).
neg(all(X, P), exists(X, P1)) :- !, neg(P, P1).
neg(exists(X, P), all(X, P1)) :- !, neg(P, P1).
neg((P & Q), (P1 # Q1)) :- !, neg(P, P1), neg(Q, Q1).
neg((P # Q), (P1 & Q1)) :- !, neg(P, P1), neg(Q, Q1).
neg(P, (~P)).

/*
negin(~(human(caesar) & living(caesar)), R).
negin(~human(caesar) # ~living(caesar), R).
negin(~(human(caesar) # living(caesar)), R).
negin(~all(y, person(y)), R).
*/


/* Stage 3 - Skolemising */
skolem(all(X, P), all(X, P1), Vars) :-
    !, skolem(P, P1, [X|Vars]).
skolem(exists(X, P), P2, Vars) :-
    !,
    gensym(f, F),
    Sk =.. [F|Vars],
    subst(X, Sk, P, P1),
    skolem(P1, P2, Vars).
skolem((P # Q), (P1 # Q1), Vars) :-
    !, skolem(P, P1, Vars), skolem(Q, Q1, Vars).
skolem((P & Q), (P1 & Q1), Vars) :-
    !, skolem(P, P1, Vars), skolem(Q, Q1, Vars).
skolem(P, P, _).


test_skolem(X, R, Vars) :- implout(X, X1), negin(X1, X2), write(X2), nl, skolem(X2, R, Vars).
/*
skolem(exists(x, female(x) & motherof(x, eve)), R, []).
test_skolem(all(x, human(x) -> exists(y, motherof(x, y))), R, []).
test_skolem(all(x, not_only_child(x) -> exists(y, motherof(x, y) & exists(z, motherof(z, y)))), R, []).
test_skolem(all(x, all(y, siblings(x, y) -> exists(z, parent(x, z) & parent(y, z)))), R, []).
*/

subst(X, Y, X, Y) :- !, atom(X).
subst(X, Y, P, P1) :-
    atom(X),
    P =.. [F|Args],
    maplist(subst(X, Y), Args, Args1),
    P1 =.. [F|Args1].

/*
subst(y, g1(x), motherof(x, y), R).
*/


/* Stage 4 - Moving universal quantifiers outwards */
univout(all(_X, P), P1) :- !, univout(P, P1).
univout((P & Q), (P1 & Q1)) :-
    !, univout(P, P1), univout(Q, Q1).
univout((P # Q), (P1 # Q1)) :-
    !, univout(P, P1), univout(Q, Q1).
univout(P, P).

/*
univout(all(x, alive(x) # dead(x)) & all(y, likes(mary, y) # impure(y)), R).
test_skolem(all(x, all(y, siblings(x, y) -> exists(z, parent(x, z) & parent(y, z)))), R1, []), univout(R1, R).
*/


/* Stage 5 - Distributing & over # */
conjn((P # Q), R) :-
    !,
    conjn(P, P1), conjn(Q, Q1),
    conjn1((P1 # Q1), R).
conjn((P & Q), (P1 & Q1)) :- !, conjn(P, P1), conjn(Q, Q1).
conjn(P, P).

conjn1(((P & Q) # R), (P1 & Q1)) :-
    !, conjn((P # R), P1), conjn((Q # R), Q1).
conjn1((P # (Q & R)), (Q1 & R1)) :-
    !, conjn((P # Q), Q1), conjn((P # R), R1).
conjn1(P, P).

/*
conjn(holiday(x) # (work(chris, x) & (angry(chris) # sad(chris))), R).
*/


/* Stage 6 - Putting into clauses */
clausify((P & Q), C1, C2) :-
    !, clausify(P, C1, C3), clausify(Q, C3, C2).
clausify(P, [cl(A, B)|Cs], Cs) :-
    inclause(P, A, [], B, []), !.
clausify(_, C, C).

inclause((P # Q), A, A1, B, B1) :-
    !,
    inclause(P, A2, A1, B2, B1), inclause(Q, A, A2, B, B2).
inclause((~P), A, A, B1, B) :-
    !, notin(P, A), putin(P, B, B1).
inclause(P, A1, A, B, B) :- notin(P, B), putin(P, A, A1).

notin(X, [X|_]) :- !, fail.
notin(X, [_|L]) :- !, notin(X, L).
notin(_X, []).

putin(X, [], [X]) :- !.
putin(X, [X|L], [X|L]) :- !.
putin(X, [Y|L], [Y|L1]) :- putin(X, L, L1).

/*
conjn(holiday(x) # (work(chris, x) & (angry(chris) # sad(chris))), R1), clausify(R1, R, []).
clausify((person(adam) & person(eve)) & ((person(x) # ~mother(x, y)) # ~person(y)), R, []).
*/


/* Printing out clauses */
pclauses([]) :- !, nl, nl.
pclauses([cl(A, B)|Cs]) :-
    pclause(A, B), nl, pclauses(Cs).

pclause(L, []) :-
    !, pdisj(L), write('.').
pclause([], L) :-
    !, write(':- '), pconj(L), write('.').
pclause(L1, L2) :-
    pdisj(L1),
    write(' :- '), pconj(L2), write('.').

pdisj([L]) :- !, write(L).
pdisj([L|Ls]) :- write(L), write('; '), pdisj(Ls).

pconj([L]) :- !, write(L).
pconj([L|Ls]) :- write(L), write(', '), pconj(Ls).

/*
conjn(holiday(x) # (work(chris, x) & (angry(chris) # sad(chris))), R1), clausify(R1, R, []), pclauses(R), fail.
clausify((person(adam) & person(eve)) & ((person(x) # ~mother(x, y)) # ~person(y)), R, []), pclauses(R), fail.

translate(all(x, all(y, person(y) -> respect(y, x)) -> king(x))).

X = all(x, all(y, person(y) -> respect(y, x)) -> king(x)),
    implout(X, X1),
    negin(X1, X2),
    skolem(X2, X3, []),
    univout(X3, X4),
    conjn(X4, X5),
    clausify(X5, Clauses, []),
    pclauses(Clauses).
*/
