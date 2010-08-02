:- op(200, yf, ++).

:- arithmetic_function('++'/1).

++(X, Y) :- Y is X + 1.

/*
X = 5, Y is X++ .
X = 5, Y is X ++ ++ .
X = 5, Y is -X++ ++ .     % X = 5, Y = -3.
*/
