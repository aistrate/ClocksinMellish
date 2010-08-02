fuel_consumed(waster, [3.1, 10.4, 15.9, 10.3]).
fuel_consumed(guzzler, [3.2, 9.9, 13.0, 11.6]).
fuel_consumed(prodigal, [2.8, 9.8, 13.1, 10.4]).

equal_or_better_consumption(Good, Bad) :-
    Threshold is (Good + Bad) / 40,
    Worst is Bad + Threshold,
    Good < Worst.

prefer_car(Car1, Car2) :-
    fuel_consumed(Car1, Con1),
    fuel_consumed(Car2, Con2),
    always_better(Con1, Con2).

always_better([], []).
always_better([Con1|T1], [Con2|T2]) :-
    equal_or_better_consumption(Con1, Con2),
    always_better(T1, T2).

sometimes_better([Con1|_], [Con2|_]) :-
    equal_or_better_consumption(Con1, Con2).

sometimes_better([_|Con1], [_|Con2]) :-
    sometimes_better(Con1, Con2).

sometimes_prefer_car(Car1, Car2) :-
    fuel_consumed(Car1, Con1),
    fuel_consumed(Car2, Con2),
    sometimes_better(Con1, Con2).
