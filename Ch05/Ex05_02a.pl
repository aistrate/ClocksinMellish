go :- repeat, get_char(C), deal_with(C), fail.

deal_with(a) :- !, put_char(b).
deal_with(X) :- put_char(X).
