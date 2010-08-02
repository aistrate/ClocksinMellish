mylast(X, [X]).
mylast(X, [_|Y]) :- mylast(X, Y).

% does not work for: rev(X, [a, b, c])
% (it hangs after the (correct) first solution)
rev([], []).
rev([H|T], L) :- rev(T, Z), append(Z, [H], L).

rev2(L1, L2) :- revzap(L1, [], L2).
revzap([], L, L) :- !.
revzap([X|L], L2, L3) :- revzap(L, [X|L2], L3).

efface(A, [A|L], L) :- !.
efface(A, [B|L], [B|M]) :- efface(A, L, M).
efface(_, [], []).

subst(_, [], _, []).
subst(X, [X|L], A, [A|M]) :- !, subst(X, L, A, M).
subst(X, [Y|L], A, [Y|M]) :- subst(X, L, A, M).

% standard predicate:
% ?- sublist(atom, [a, b, 3, c, [a, b], d, X, e, Y], R).
%       =>      R = [a, b, c, d, e].

sublist([X|L], [X|M]) :- prefix(L, M), !.
sublist(L, [_|M]) :- sublist(L, M).

prefix([], _).
prefix([X|L], [X|M]) :- prefix(L, M).


remdup(L, M) :- dupacc(L, [], M1), reverse(M1, M).

dupacc([], A, A).
dupacc([H|T], A, L) :- member(H, A), !, dupacc(T, A, L).
dupacc([H|T], A, L) :- dupacc(T, [H|A], L).
