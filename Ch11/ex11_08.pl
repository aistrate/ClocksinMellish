permute([], []).
permute([H|T], L) :-
    permute(T, L1),
    append(L2, L3, L1),
    append(L2, [H|L3], L).


check_diags([]).
check_diags([H|T]) :-
    check_diag(H, 1, T),
    check_diags(T).

check_diag(_, _, []).
check_diag(R, N, [H|T]) :-
    R1 is R - N,
    R1 =\= H,
    R2 is R + N,
    R2 =\= H,
    N1 is N + 1,
    check_diag(R, N1, T).


queens(N, P) :-
    numlist(1, N, L),
    permute(L, P),
    check_diags(P).


% Testing
test_queens(N) :-
    findall(P, (queens(N, P), write(P), nl), Ps),
    length(Ps, L),
    write(L), write(' solutions'), nl.

/*
1:     1
2:     0
3:     0
4:     2
5:    10
6:     4
7:    40
8:    92
9:   352
10:  724
11: 2680
*/
