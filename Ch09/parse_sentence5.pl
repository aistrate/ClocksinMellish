sentence(S) --> sentence(_X, S).

sentence(X, sentence(NP, VP)) --> noun_phrase(X, NP), verb_phrase(X, VP).

noun_phrase(X, noun_phrase(D, N)) --> determiner(X, D), noun(X, N).

verb_phrase(X, verb_phrase(V)) --> verb(X, V).
verb_phrase(X, verb_phrase(V, NP)) --> verb(X, V), noun_phrase(_Y, NP).


determiner(_, determiner(the)) --> [the].

noun(singular, noun(apple)) --> [apple].
noun(plural, noun(apples)) --> [apples].
noun(singular, noun(man)) --> [man].
noun(plural, noun(men)) --> [men].
noun(singular, noun(boy)) --> [boy].
noun(plural, noun(boys)) --> [boys].

verb(singular, verb(eats)) --> [eats].
verb(plural, verb(eat)) --> [eat].
verb(singular, verb(sings)) --> [sings].
verb(plural, verb(sing)) --> [sing].

/*
phrase(sentence(S), [the, boy, eats, the, apple]), !.
phrase(sentence(S), [the, boys, eat, the, apple]), !.
phrase(sentence(X, S), [the, boy, eats, the, apple]), !.
phrase(sentence(X, S), [the, boys, eat, the, apple]), !.
*/

% parse_list(S0, S) :- append([apple], S, S0)
