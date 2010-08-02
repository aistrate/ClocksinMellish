myappend([], Y, Y).
myappend([A|B], C, [A|D]) :- myappend(B, C, D).

/*
portray(myappend(A, B, _C)) :-
    write('myappend('), write(A), write(','),
    write(B), write(','),
    write('<foo>)').
*/

rev([], []).
rev([H|T], L) :- rev(T, Z), myappend(Z, [H], L).
