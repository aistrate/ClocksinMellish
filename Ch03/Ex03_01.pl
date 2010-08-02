fuel_consumed(waster, [3.1, 10.4, 15.9, 10.3]).
fuel_consumed(guzzler, [3.2, 9.9, 13.0, 11.6]).
fuel_consumed(prodigal, [2.8, 9.8, 13.1, 10.4]).

significantly_better_consumption(Good, Bad) :-
    Threshold is (Good + Bad) / 20,
    Best is Bad - Threshold,
    Good < Best.

sometimes_prefer_car(Car1, Car2) :-
    fuel_consumed(Car1, Con1),
    fuel_consumed(Car2, Con2),
    sometimes_better(Con1, Con2).

sometimes_better([Con1|_], [Con2|_]) :-
    significantly_better_consumption(Con1, Con2).

sometimes_better([_|Con1], [_|Con2]) :-
    sometimes_better(Con1, Con2).
