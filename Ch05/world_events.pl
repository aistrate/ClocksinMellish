event(1505, ['Euclid', translated, into, 'Latin']).
event(1510, ['Reuchlin-Pfefferkorn', controversy]).
event(1523, ['Christian', 'II', flees, from, 'Denmark']).

when(X, Y) :- event(Y, Z), member(X, Z).

hello1(Event) :- read(Date), event(Date, Event).


spaces(0) :- !.
spaces(N) :- write(' '), N1 is N - 1, spaces(N1).

% pp([H|T], I) :- !, J is I + 3, pp(H, J), ppx(T, J), nl.
pp([H|T], I) :- !, J is I + 3, ppx([H|T], J).
pp(X, I) :- spaces(I), write(X), nl.

ppx([], _).
ppx([H|T], I) :- pp(H, I), ppx(T, I).


phh([]) :- nl.
phh([H|T]) :- write(H), spaces(1), phh(T).

hello2 :-
    phh(['What', date, do, you, 'desire?']),
    read(D),
    event(D, S),
    phh(S).
