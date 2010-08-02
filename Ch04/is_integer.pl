is_integer(0).
is_integer(X) :- is_integer(Y), X is Y + 1.
