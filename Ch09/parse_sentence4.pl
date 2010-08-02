sentence --> sentence(_X).

sentence(X) --> noun_phrase(X), verb_phrase(X).

noun_phrase(X) --> determiner(X), noun(X).

verb_phrase(X) --> verb(X).
verb_phrase(X) --> verb(X), noun_phrase(_Y).


determiner(_) --> [the].

noun(singular) --> [apple].
noun(plural) --> [apples].
noun(singular) --> [man].
noun(plural) --> [men].
noun(singular) --> [boy].
noun(plural) --> [boys].

verb(singular) --> [eats].
verb(plural) --> [eat].
verb(singular) --> [sings].
verb(plural) --> [sing].

/*
phrase(sentence, [the, boy, eats, the, apple]), !.
phrase(sentence, [the, boys, eat, the, apple]), !.
phrase(sentence(X), [the, boy, eats, the, apple]), !.
phrase(sentence(X), [the, boys, eat, the, apple]), !.
*/
