facility(Pers, Fac) :-
    book_overdue(Pers, Book),
    !,
    basic_facility(Fac).
facility(Pers, Fac) :- general_facility(Fac).

basic_facility(reference).
basic_facility(enquiries).

additional_facility(borrowing).
additional_facility(inter_library_loan).

general_facility(X) :- basic_facility(X).
general_facility(X) :- additional_facility(X).


client('A. Jones').
client('W. Metesk').

book_overdue('C. Watzer', book10089).
book_overdue('A. Jones', book29907).
