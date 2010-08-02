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

/* 
a_tree(T), lookup(adela, T, G).
a_tree(T), lookup(geronimo, T, G).
lookup(geronimo, T, 158), lookup(fidel, T, 1111).
*/
