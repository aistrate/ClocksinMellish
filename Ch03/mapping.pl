change(you, i).
change(are, [am, not]).
change(french, german).
change(do, no).
change(X, X).

alter([], []).
alter([H|T], [X|Y]) :- change(H, X), alter(T, Y).
