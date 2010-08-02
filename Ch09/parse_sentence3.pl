sentence --> noun_phrase, verb_phrase.

noun_phrase --> determiner, noun.

verb_phrase --> verb.
verb_phrase --> verb, noun_phrase.


determiner --> [the].

noun --> [apple].
noun --> [man].

verb --> [eats].
verb --> [sings].


myphrase(P, L) :- Goal =.. [P, L, []], call(Goal).
