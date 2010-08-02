sum_to(N, 1) :- N =< 1.
sum_to(N, Res) :-
    N > 1,
    N1 is N - 1,
    sum_to(N1, Res1),
    Res is Res1 + N.


go :- sum_to(1, X), foo(apples).

foo(pears).
