copy(Old, New) :- functor(Old, F, N), functor(New, F, N).

% copy(sentence(np(n(john)), v(eats)), X).

% X = [a, b, c], functor(X, F, N), arg(1, X, A1), arg(2, X, A2).
