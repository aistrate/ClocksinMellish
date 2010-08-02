/* Bicycle */
basicpart(rim).
basicpart(spoke).
basicpart(rearframe).
basicpart(handles).
basicpart(gears).
basicpart(bolt).
basicpart(nut).
basicpart(fork).

assembly(bike, [quant(wheel, 2), quant(frame, 1)]).
assembly(wheel, [quant(spoke, 50), quant(rim, 1), quant(hub, 1)]).
assembly(frame, [quant(rearframe, 1), quant(frontframe, 1)]).
assembly(frontframe, [quant(fork, 1), quant(handles, 1)]).
assembly(hub, [quant(gears, 1), quant(axle, 1)]).
assembly(axle, [quant(bolt, 1), quant(nut, 1)]).


partlist(T) :-
    partsof(1, T, P),
    collect(P, Q),
    !,
    printpartlist(Q).

partsof(N, X, P) :- assembly(X, S), partsoflist(N, S, P).
partsof(N, X, [quant(X, N)]) :- basicpart(X).

partsoflist(_, [], []).
partsoflist(N, [quant(X, Num)|L], T) :-
    M is N * Num,
    partsof(M, X, Xparts),
    partsoflist(N, L, Restparts),
    append(Xparts, Restparts, T).


collect([], []).
collect([quant(X, N)|R], [quant(X, Ntotal)|R2]) :-
    collectrest(X, N, R, O, Ntotal),
    collect(O, R2).

collectrest(_, N, [], [], N).
collectrest(X, N, [quant(X, Num)|Rest], Others, Ntotal) :-
    !,
    M is N + Num,
    collectrest(X, M, Rest, Others, Ntotal).
collectrest(X, N, [Other|Rest], [Other|Others], Ntotal) :-
    collectrest(X, N, Rest, Others, Ntotal).

printpartlist([]).
printpartlist([quant(X, N)|R]) :-
    write(' '), write(N), put_char('\t'), write(X), nl,
    printpartlist(R).
