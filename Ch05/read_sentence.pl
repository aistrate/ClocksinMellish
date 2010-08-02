/* Read in a sentence */
read_in([W|Ws]) :- get_char(C), readword(C, W, C1), restsent(W, C1, Ws).


/* Given a word and the character after it, 
   read in the rest of the sentence */
restsent(W, _, []) :- lastword(W), !.
restsent(_, C, [W1|Ws]) :- readword(C, W1, C1), restsent(W1, C1, Ws).


/* Read in a single word, given an initial characte, and 
   remembering which character came after the word */
readword(C, C, C1) :- single_character(C), !, get_char(C1).
readword(C, W, C2) :-
    in_word(C, NewC),
    !,
    get_char(C1),
    restword(C1, Cs, C2),
    atom_chars(W, [NewC|Cs]).
readword(_, W, C2) :- get_char(C1), readword(C1, W, C2).

restword(C, [NewC|Cs], C2) :-
    in_word(C, NewC),
    !,
    get_char(C1), restword(C1, Cs, C2).
restword(C, [], C).


/* These characters can appear within a word. The second
   in_word clause converts letters to lower-case */
in_word(C, C) :- letter(C, _).         /* a b...z */
in_word(C, L) :- letter(L, C).         /* A B...Z */
in_word(C, C) :- digit(C).             /* 1 2...9 */
in_word(C, C) :- special_character(C). /* '.' */


/* Special characters */
special_character('-').
special_character('''').


/* These characters form words on their own */
single_character(',').
single_character('.').
single_character(';').
single_character(':').
single_character('?').
single_character('!').


/* Upper and lower case letters */
letter(L, U) :-
    \+ var(L),
    char_type(L, T),
    T = lower(U), !.

letter(L, U) :-
    \+ var(U),
    char_type(U, T),
    T = upper(L), !.

/*
letter(L, U) :- 
    char_code(L, LC), 
    char_code('a', LowerA), char_code('z', LowerZ),
    LowerA =< LC, LC =< LowerZ, !,
    char_code('A', UpperA), UC is LC - LowerA + UpperA,
    char_code(U, UC).

letter(L, U) :- 
    char_code(U, UC), 
    char_code('A', UpperA), char_code('Z', UpperZ),
    UpperA =< UC, UC =< UpperZ,
    char_code('a', LowerA), LC is UC - UpperA + LowerA,
    char_code(L, LC).
*/


/* Digits */
digit(X) :- char_type(X, T), T = digit, !.

/*
digit(X) :- 
    char_code(X, C), 
    char_code('0', Zero), char_code('9', Nine),
    Zero =< C, C =< Nine.
*/


/* These words terminate a sentence */
lastword('.').
lastword('!').
lastword('?').
