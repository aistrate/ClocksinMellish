average_taxpayer(X) :- foreigner(X), !, fail.

average_taxpayer(X) :-
    spouse(X, Y),
    gross_income(Y, Inc),
    Inc > 3000,
    !, fail.

average_taxpayer(X) :-
    gross_income(X, Inc),
    2000 < Inc, 20000 > Inc.

gross_income(X, Y) :-
    receives_pension(X, P),
    P < 5000,
    !, fail.

gross_income(X, Y) :-
    gross_salary(X, Z),
    investment_income(X, W),
    Y is Z + W.


foreigner('R. Schmidt').
foreigner('A. Schmidt').

spouse('R. Schmidt', 'A. Schmidt').

gross_salary('M. Jones', 12000).
gross_salary('M. Jagger', 15000).
gross_salary('R. Schmidt', 18000).

investment_income('M. Jones', 5000).
investment_income('M. Jagger', 0).
investment_income('R. Schmidt', 0).

receives_pension('W.K. Jones', 4500).
