/* Bicycle */
basicpart(rim).
basicpart(spoke).
basicpart(rearframe).
basicpart(handles).
basicpart(gears).
basicpart(bolt).
basicpart(nut).
basicpart(fork).

/* English sentence */
basicpart(the).
basicpart('a(n)').
basicpart(apple).
basicpart(orange).
basicpart(fruit).
basicpart(is).


/* Bicycle */
assembly(bike, [wheel, wheel, frame]).
assembly(wheel, [spoke, rim, hub]).
assembly(frame, [rearframe, frontframe]).
assembly(frontframe, [fork, handles]).
assembly(hub, [gears, axle]).
assembly(axle, [bolt, nut]).

/* English sentence */
assembly(sentence, [noun_phrase, verb_phrase]).
assembly(noun_phrase, [determiner, noun]).
assembly(verb_phrase, [verb, noun_phrase]).

assembly(determiner, [the]).
assembly(determiner, ['a(n)']).
assembly(noun, [apple]).
assembly(noun, [orange]).
assembly(noun, [fruit]).
assembly(verb, [is]).


partsof(X, P) :- partsacc(X, P, Hole), Hole = [].

partsacc(X, [X|Hole], Hole) :- basicpart(X). 
partsacc(X, P, Hole) :-
    assembly(X, Subparts),
    partsacclist(Subparts, P, Hole).

partsacclist([], Hole, Hole).
partsacclist([P|Tail], Total, Hole) :-
    partsacc(P, Total, Hole1),
    partsacclist(Tail, Hole1, Hole).
