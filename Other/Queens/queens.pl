nqueens(Size, Out) :-
    numlist(1, Size, UnplacedQueens),
    nqueens([], UnplacedQueens, Out).

nqueens(Out, [], Out).
nqueens(PlacedQueens, UnplacedQueens, Out) :-
    select(Queen, UnplacedQueens, NewUnplacedQueens),
    cannotAttack(Queen, PlacedQueens),
    nqueens([Queen|PlacedQueens], NewUnplacedQueens, Out).


cannotAttack(Row, PlacedQueens) :- cannotAttack(Row, 1, PlacedQueens).

cannotAttack(_Row, _N, []).
cannotAttack(Row, N, [Queen|PlacedQueens]) :-
    Queen =\= Row - N,
    Queen =\= Row + N,
    Next is N + 1,
    cannotAttack(Row, Next, PlacedQueens).


solutions(Size, List) :-
    findall(Out, nqueens(Size, Out), List).


myselect(Elem, [Elem|Rest], Rest).
myselect(Elem, [Head|Tail], [Head|ElemLessList]) :- myselect(Elem, Tail, ElemLessList).
