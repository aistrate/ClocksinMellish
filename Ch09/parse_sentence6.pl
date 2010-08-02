sentence(S) --> sentence(_X, S).

sentence(X, sentence(NP, VP)) --> noun_phrase(X, NP), verb_phrase(X, VP).

noun_phrase(X, noun_phrase(D, N)) --> determiner(X, D), noun(X, N).

verb_phrase(X, verb_phrase(V)) --> verb(X, V).
verb_phrase(X, verb_phrase(V, NP)) --> verb(X, V), noun_phrase(_Y, NP).


determiner(_, determiner(the)) --> [the].


is_noun(banana, singular).
is_noun(apple, singular).
is_noun(boy, singular).

noun(singular, noun(man)) --> [man].
noun(plural, noun(man)) --> [men].
noun(singular, noun(child)) --> [child].
noun(plural, noun(child)) --> [children].

noun(S, noun(N)) --> [N], {is_noun(N, S)}.
noun(plural, noun(RootN)) -->
    [N],
    {   atom_chars(N, PlName),
        append(SingName, [s], PlName),
        atom_chars(RootN, SingName),
        is_noun(RootN, singular)}.


verb(singular, verb(eats)) --> [eats].
verb(plural, verb(eat)) --> [eat].
verb(singular, verb(sings)) --> [sings].
verb(plural, verb(sing)) --> [sing].

/*
phrase(sentence(X, S), [the, boy, eats, the, apple]), !.
phrase(sentence(X, S), [the, boys, eat, the, apple]), !.
phrase(sentence(X, S), [the, boy, eat, the, apple]), !.
phrase(sentence(X, S), [the, boys, eats, the, apple]), !.
phrase(sentence(X, S), [the, man, eats, the, bananas]), !.
phrase(sentence(X, S), [the, men, eat, the, banana]), !.
phrase(sentence(X, S), [the, mans, eat, the, banana]), !.
phrase(sentence(X, S), [the, child, sings]), !.
phrase(sentence(X, S), [the, children, sing]), !.
phrase(sentence(X, S), [the, child, sing]), !.
phrase(sentence(X, S), [the, children, sings]), !.
phrase(sentence(X, S), [the, childs, sing]), !.
phrase(sentence(X, S), [the, childs, sings]), !.
*/
