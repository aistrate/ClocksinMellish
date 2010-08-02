sentence(S0, S) :-
    noun_phrase(S0, S1),
    verb_phrase(S1, S).

noun_phrase(S0, S) :-
    determiner(S0, S1), noun(S1, S).

verb_phrase(S0, S) :- verb(S0, S).
verb_phrase(S0, S) :-
    verb(S0, S1), noun_phrase(S1, S).


determiner([the|S], S).

noun([apple|S], S).
noun([man|S], S).

verb([eats|S], S).
verb([sings|S], S).
