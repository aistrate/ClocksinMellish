?- op(500, xfy, &).
?- op(600, xfy, ->).

sentence(P) -->
    noun_phrase(X, P1, P), verb_phrase(X, P1).

noun_phrase(X, P1, P) -->
    determiner(X, P2, P1, P),
    noun(X, P3),
    rel_clause(X, P3, P2).
noun_phrase(X, P, P) --> proper_noun(X).

verb_phrase(X, P) -->
    trans_verb(X, Y, P1), noun_phrase(Y, P1, P).
verb_phrase(X, P) --> intrans_verb(X, P).

rel_clause(X, P1, (P1 & P2)) -->
    [that], verb_phrase(X, P2).
rel_clause(_, P, P) --> [].

determiner(X, P1, P2, all(X, (P1 -> P2))) --> [every].
determiner(X, P1, P2, exists(X, (P1 & P2))) --> [a].

noun(X, man(X)) --> [man].
noun(X, woman(X)) --> [woman].

proper_noun(john) --> [john].

trans_verb(X, Y, loves(X, Y)) --> [loves].

intrans_verb(X, lives(X)) --> [lives].


write_numvar(X) :-
    numbervars(X, 0, _), write_term(X, [numbervars(true)]).

/*
phrase(sentence(X), [every, man, loves, a, woman]), write_numvar(X), fail.
phrase(sentence(X), [every, man, that, lives, loves, a, woman]), write_numvar(X), fail.
phrase(sentence(X), [every, man, that, loves, a, woman, lives]), write_numvar(X), fail.
phrase(sentence(X), [john, loves, a, woman]), write_numvar(X), fail.
phrase(sentence(X), [every, woman, loves, john]), write_numvar(X), fail.
*/
