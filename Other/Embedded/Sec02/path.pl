path(X, X, [X]).
path(X, Z, [X|Nodes]) :- edge(X, Y), path(Y, Z, Nodes).

edge(a, b).
edge(a, d).
edge(b, c).
edge(b, d).
edge(c, d).
edge(c, e).
edge(d, e).
