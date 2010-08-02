sentence(X) :-
    append(Y, Z, X), noun_phrase(Y), verb_phrase(Z).

noun_phrase(X) :-
    append(Y, Z, X), determiner(Y), noun(Z).

verb_phrase(X) :-
    append(Y, Z, X), verb(Y), noun_phrase(Z).
verb_phrase(X) :- verb(X).


determiner([the]).

noun([apple]).
noun([man]).

verb([eats]).
verb([sings]).
