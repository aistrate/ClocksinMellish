permute([], []).
permute(L, [H|P]) :-
    append(L1, [H|L2], L),
    append(L1, L2, L3),
    permute(L3, P).


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

ratios([_], []) :- !.
ratios([A|[B|T]], [R|Rs]) :-
    R is B / A,
    ratios([B|T], Rs).

products([_], []) :- !.
products([A|[B|T]], [P|Ps]) :-
    P is B * A,
    products([B|T], Ps).

/*
ratios([2, 10, 4, 40, 92, 352, 724, 2680], R), products(R, P).
=>  R = [5, 0.4, 10, 2.3, 3.82609, 2.05682, 3.70166],
    P = [2.0, 4.0, 23.0, 8.8, 7.86957, 7.61364].
*/
