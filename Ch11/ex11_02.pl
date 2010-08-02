interval(D1, D2, N) :-
    day_in_year(D1, N1),
    day_in_year(D2, N2),
    N is N2 - N1.

day_in_year(D-Month, N) :-
    month(Month, M),
    M1 is M - 1,
    days_in_month(Ds),
    sum_first(M1, Ds, S),
    N is S + D.

sum_first(0, _, 0) :- !.
sum_first(N, [H|T], S) :-
    N1 is N - 1,
    sum_first(N1, T, S1),
    S is S1 + H.


month(january, 1).
month(february, 2).
month(march, 3).
month(april, 4).
month(may, 5).
month(june, 6).
month(july, 7).
month(august, 8).
month(september, 9).
month(october, 10).
month(november, 11).
month(december, 12).

days_in_month(X) :- X = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31].

/*
interval(3-march, 7-april, 35).
interval(3-march, 7-april, X).
interval(1-january, 31-december, 364).
interval(1-february, 1-february, X).
interval(1-june, 1-july, X).
interval(1-january, 13-august, X).
*/
