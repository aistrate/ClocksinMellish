new_get(X) :- repeat, get_char(X).

% new_get(X), put_char(X), X = '.'.


get_non_space(X) :- new_get(X), \+ X = ' '.

% get_non_space(X), put_char(X), X = '.'.
