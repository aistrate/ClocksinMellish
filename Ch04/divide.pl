is_integer(0).
is_integer(X) :- is_integer(Y), X is Y + 1.


divide(N1, N2, Result) :-
    is_integer(Result),
    Product1 is Result * N2,
    Product2 is (Result + 1) * N2,
    Product1 =< N1, Product2 > N1,
    !.
