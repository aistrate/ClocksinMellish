a_tree(T) :-
    T = w(massinga, 858,
            w(braemar, 385,
                w(adela, 588, _, _),
                _),
            w(panorama, 158,
                w(nettleweed, 579, _, _),
                _)
            ).


lookup(H, w(H, G, _, _), G1) :- !, G = G1.

lookup(H, w(H1, _, Before, _), G) :-
    H @< H1,
    lookup(H, Before, G).

lookup(H, w(H1, _, _, After), G) :-
    H @> H1,
    lookup(H, After, G).


list_to_tree([], _) :- !.
list_to_tree([p(H, G)|Tail], Tree) :-
    lookup(H, Tree, G),
    list_to_tree(Tail, Tree).

/*
list_to_tree([p(massinga, 111), p(braemar, 222), p(nettleweed, 333), p(panorama, 444)], Tree).
list_to_tree([p(adela, 111), p(braemar, 222), p(nettleweed, 333), p(massinga, 444)], Tree).
*/
