/*
?- op(1199, xfx, *-->).

(H *--> B) :-
    NewH =.. [H, In, Out],
    'CC'()
*/

:- dynamic 'C'/3.

'C'(Old, X, New) :- New is Old + X.

listlen(L, N) :- lenacc(L, 0, N).

lenacc([]) --> [].
lenacc([H|T]) --> [1], lenacc(T).

/*
lenacc([], In, Out) :-'C'(In, )
lenacc([H|T], In, Out) :- 'C'(In, 1, Out1), 'C'(T, Out1, Out).
*/
