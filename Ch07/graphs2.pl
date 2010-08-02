printlist(X) :- member(E, X), write(E), write(' '), fail.
printlist(_) :- nl.


a(newcastle, carlisle, 58).
a(carlisle, penrith, 23).
a(smallville, metropolis, 15).
% a(darlington, newcastle, 40).
a(penrith, darlington, 52).
a(smallville, ambridge, 10).
a(workington, carlisle, 33).
a(workington, ambridge, 5).
a(workington, penrith, 39).
a(darlington, metropolis, 25).


a(X, Y) :- a(X, Y, _Z).

legal(_X, []).
legal(X, [H|T]) :- \+ X = H, legal(X, T).


go(Start, Dest, Route) :-
    go0(Start, Dest, [], R),
    reverse(R, Route).

go0(X, X, T, [X|T]).
go0(Place, Y, T, R) :-
    legalnode(Place, T, Next),
    go0(Next, Y, [Place|T], R).

legalnode(X, Trail, Y) :-
    (a(X, Y); a(Y, X)),
    legal(Y, Trail).

% go(darlington, workington, R), write(R), nl, fail.


% depth first / breadth first
go_breadthfirst(Start, Dest, Route) :-
    go1([[Start]], Dest, R),
    reverse(R, Route).

go1([First|_Rest], Dest, First) :- First = [Dest|_].
go1([[Last|Trail]|Others], Dest, Route) :-
    findall([Z, Last|Trail], legalnode(Last, Trail, Z), List),
    % append(List, Others, NewRoutes),
    append(Others, List, NewRoutes),
    go1(NewRoutes, Dest, Route).


% best first
go_bestfirst(Start, Dest, r(Dist, Route)) :-
    go3([r(0, [Start])], Dest, r(Dist, R)),
    reverse(R, Route).

go3(Routes, Dest, Route) :-
    shortest(Routes, Shortest, RestRoutes),
    proceed(Shortest, Dest, RestRoutes, Route).

proceed(r(Dist, Route), Dest, _, r(Dist, Route)) :-
    Route = [Dest|_].
proceed(r(Dist, [Last|Trail]), Dest, Routes, Route) :-
    findall(r(D1, [Z, Last|Trail]),
            legalnode3(Last, Trail, Z, Dist, D1),
            List),
    append(List, Routes, NewRoutes),
    go3(NewRoutes, Dest, Route).

shortest([Route|Routes], Shortest, [Route|Rest]) :-
    shortest(Routes, Shortest, Rest),
    shorter(Shortest, Route),
    !.
shortest([Route|Rest], Route, Rest).

shorter(r(M1, _), r(M2, _)) :- M1 < M2.

legalnode3(X, Trail, Y, Dist, NewDist) :-
    (a(X, Y, Z); a(Y, X, Z)),
    legal(Y, Trail),
    NewDist is Dist + Z.
