order(X, Y) :- X @=< Y.

printlist(X) :- member(E, X), write(E), write(' '), fail.
printlist(_) :- nl.


% Insertion sort
insort([], []).
insort([X|L], M) :- insort(L, N), insortx(X, N, M).

insortx(X, [A|L], [A|M]) :-
    order(A, X), !, insortx(X, L, M).
insortx(X, L, [X|L]).


% Quicksort
split(H, [A|X], [A|Y], Z) :- order(A, H), split(H, X, Y, Z).
split(H, [A|X], Y, [A|Z]) :- \+ order(A, H), split(H, X, Y, Z).
split(_, [], [], []).

quisort([], []).
quisort([H|T], S) :-
    split(H, T, A, B),
    quisort(A, A1),
    quisort(B, B1),
    append(A1, [H|B1], S).

quisort2(L, S) :- quisortx(L, S, []).

quisortx([], X, X).
quisortx([H|T], S, X) :-
    split(H, T, A, B),
    quisortx(A, S, [H|Y]),
    quisortx(B, Y, X).


% Quicksort hybrid
split2(H, [A|X], [A|Y], Z, L) :- order(A, H), split2(H, X, Y, Z, L1), L is L1 + 1.
split2(H, [A|X], Y, [A|Z], L) :- \+ order(A, H), split2(H, X, Y, Z, L1), L is L1 + 1.
split2(_, [], [], [], 1).

quisort_hybrid([H|T], S) :-
    split2(H, T, A, B, L),
    L >= 50, !,
    quisort_hybrid(A, A1),
    quisort_hybrid(B, B1),
    append(A1, [H|B1], S).
quisort_hybrid(X, S) :-
    insort(X, S).


testdata(X) :-
    numlist(1, 2000, X1), 
    numlist(2001, 4000, X2), reverse(X2, X21), 
    numlist(4001, 6000, X3), 
    append(X1, X21, X22), 
    append(X22, X3, X).


/*
testdata(X), insort(X, Y), printlist(Y), fail.
testdata(X), quisort_hybrid(X, Y), printlist(Y), fail.
numlist(1, 3000, X), reverse(X, Y), quisort_hybrid(Y, S), printlist(S), fail.
*/


randomlist(0, _M, []) :- !.
randomlist(N, M, [X|L]) :-
    random(0, M, X),
    N1 is N - 1,
    randomlist(N1, M, L).

testdata2(X) :- randomlist(100000, 1000000, X).

/*
testdata2(X), insort(X, Y), printlist(Y), fail.
testdata2(X), quisort_hybrid(X, Y), printlist(Y), fail.
*/
