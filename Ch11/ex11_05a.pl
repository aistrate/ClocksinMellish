read_file(File, Chars) :-
    current_input(Old),
    open(File, read, Stream),
    set_input(Stream),
    read_chars(Chars),
    close(Stream),
    set_input(Old),
    !.

/*
read_file('ex11_02.pl', Chars), write(Chars), fail.
read_file('ex11_02.pl', Chars), chars_to_words(Chars, Words), write(Words), fail.
*/

read_chars(Chars) :-
    get_char(Char),
    read_chars2(Char, [], Chars0),
    reverse(Chars0, Chars).

read_chars2(end_of_file, AccChars, AccChars) :- !.
read_chars2(Char, AccChars, Chars) :-
    get_char(NextChar),
    read_chars2(NextChar, [Char|AccChars], Chars).


chars_to_words(Chars, [W|Words]) :-
    word(WC, Chars, RestChars),
    atom_chars(W, WC), 
    !,
    chars_to_words(RestChars, Words).
chars_to_words(Chars, []) :- non_word_chars(Chars, []).


word(W) --> non_word_chars, word_chars(W).

non_word_chars --> [C], {is_non_word_char(C)}, !, non_word_chars.
non_word_chars --> !.

word_chars([C|W]) --> [C], {is_word_char(C)}, !, word_chars2(W).
word_chars2([C|W]) --> [C], {is_word_char(C)}, !, word_chars2(W).
word_chars2([]) --> !.


is_non_word_char(C) :- \+ is_word_char(C).

is_word_char(C) :- char_type(C, alnum), !.
is_word_char('_').


/*
atom_codes('  apple', X), phrase(non_word_chars, X, Y), atom_codes(A, Y).
atom_codes('\napple', X), phrase(non_word_chars, X, Y), atom_codes(A, Y).
atom_codes(' \n    apple', X), phrase(non_word_chars, X, Y), atom_codes(A, Y).
atom_codes('apple', X), phrase(non_word_chars, X, Y), atom_codes(A, Y).
atom_codes('  ', X), phrase(non_word_chars, X, Y), atom_codes(A, Y).
atom_codes('', X), phrase(non_word_chars, X, Y), atom_codes(A, Y).
atom_codes(' \n    apple  \n', X), phrase(word(W), X, Y), atom_codes(WA, W), atom_codes(A, Y).
atom_codes('apple\n', X), phrase(word(W), X, Y), atom_codes(WA, W), atom_codes(A, Y).
atom_codes('apple', X), phrase(word(W), X, Y), atom_codes(WA, W), atom_codes(A, Y).
atom_codes('', X), phrase(word(W), X, Y), atom_codes(WA, W), atom_codes(A, Y).
*/
