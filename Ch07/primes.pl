printlist(X) :- member(E, X), write(E), write(' '), fail.
printlist(_) :- nl.


primes(Limit, Ps) :-
    integers(2, Limit, Is),
    sift(Is, Ps).

integers(Low, High, [Low|Rest]) :-
    Low =< High,
    !,
    M is Low + 1,
    integers(M, High, Rest).
integers(_, _, []).

sift([], []).
sift([I|Is], [I|Ps]) :-
    remove(I, Is, New),
    sift(New, Ps).

remove(_P, [], []).
remove(P, [I|Is], [I|Nis]) :-
    \+ 0 is I mod P,
    !,
    remove(P, Is, Nis).
remove(P, [I|Is], Nis) :-
    0 is I mod P,
    !,
    remove(P, Is, Nis).

% primes(20000, P), printlist(P), length(P, L), nl, write(L), fail.


primes2(Limit, Ps) :-
    integers(2, Limit, Is),
    primes(Is, _, Ps).

primes([], P, R) :- reverse(P, R).
primes([H|T], P, Z) :-
    legal(H, P),
    !,
    primes(T, [H|P], Z).
primes([_H|T], P, Z) :- primes(T, P, Z).

legal(_X, []).
legal(X, [H|_]) :-
    0 is X mod H,
    !,
    fail.
legal(X, [_|L]) :- legal(X, L).


gcd(I, 0, I) :- !.
gcd(I, J, K) :- R is I mod J, gcd(J, R, K).

lcm(I, J, K) :- gcd(I, J, R), K is (I * J) // R.
