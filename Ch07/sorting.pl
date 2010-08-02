order(X, Y) :- X @=< Y.


% Naive sort
naivesort(L1, L2) :- mypermutation(L1, L2), sorted(L2), !.

mypermutation([], []).
mypermutation(L, [H|T]) :-
    append(V, [H|U], L),
    append(V, U, W),
    mypermutation(W, T).

mypermutation2([], [], []).
mypermutation2([C|A], D, [_|B]) :-
	mypermutation2(A, E, B),
	select(C, D, E).

mypermutation2(A, B) :-
	mypermutation2(A, B, B).

mypermutation3([], []).
mypermutation3([C|A], D) :-
	mypermutation3(A, E),
	select(C, D, E).

sorted([]).
sorted([_X]).
sorted([X, Y|L]) :- order(X, Y), sorted([Y|L]).


% Insertion sort
insort([], []).
insort([X|L], M) :- insort(L, N), insortx(X, N, M).

insortx(X, [A|L], [A|M]) :-
    order(A, X), !, insortx(X, L, M).
insortx(X, L, [X|L]).

printlist(X) :- member(E, X), write(E), write(' '), fail.

insort2([], [], _O).
insort2([X|L], M, O) :- insort2(L, N, O), insortx2(X, N, M, O).

insortx2(X, [A|L], [A|M], O) :-
    P =.. [O, A, X],
    call(P), 
    !,
    insortx2(X, L, M, O).
insortx2(X, L, [X|L], _O).


% Bubble sort
busort(L, S) :-
    append(X, [A, B|Y], L),
    order(B, A), !,
    append(X, [B, A|Y], M),
    busort(M, S).
busort(L, L).


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
