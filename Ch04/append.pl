myappend([], L, L).
myappend([X|L1], L2, [X|L3]) :- myappend(L1, L2, L3).

myappend2([], L, L) :- !.
myappend2([X|L1], L2, [X|L3]) :- myappend2(L1, L2, L3).
