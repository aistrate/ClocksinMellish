number_of_parents(adam, 0) :- !.
number_of_parents(eve, 0) :- !.
number_of_parents(X, 2).


number_of_parents2(adam, N) :- !, N = 0.
number_of_parents2(eve, N) :- !, N = 0.
number_of_parents2(X, 2).


number_of_parents3(adam, 0).
number_of_parents3(eve, 0).
number_of_parents3(X, 2) :- \+(X = adam), \+(Y = eve).

/* Tests:
number_of_parents3(adam, X).
number_of_parents3(john, X).
number_of_parents3(adam, 2).
number_of_parents3(X, Y).
number_of_parents3(X, 0).
number_of_parents3(X, 1).
number_of_parents3(X, 2).
*/
