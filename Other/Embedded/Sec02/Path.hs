import LogVars


path x z nodes =
    x =. z &. nodes =. x ::: Nil
    |. exists(\nodes' -> nodes =. x ::: nodes' 
                      &. exists(\y -> edge x y &. path y z nodes'))

{-
solve(path (Atom "a") (Atom "a") (Var (Id "Nodes")))
solve(path (Atom "a") (Atom "b") (Var (Id "Nodes")))
solve(path (Atom "a") (Atom "e") (Var (Id "Nodes")))
-}

-- edge :: Term -> Term -> Pred
-- edge x y =  (x =. Atom "a" &. y =. Atom "b")
--          |. (x =. Atom "a" &. y =. Atom "d")
--          |. (x =. Atom "b" &. y =. Atom "c")
--          |. (x =. Atom "b" &. y =. Atom "d")
--          |. (x =. Atom "c" &. y =. Atom "d")
--          |. (x =. Atom "c" &. y =. Atom "e")
--          |. (x =. Atom "d" &. y =. Atom "e")

edge :: Term -> Term -> Pred
edge x y = foldr (|.) false [ x =. Atom a &. y =. Atom b | (a, b) <- graph ]
    where graph = [ ("a", "b"), ("a", "d"), ("b", "c"), ("b", "d"),
                    ("c", "d"), ("c", "e"), ("d", "e") ]

{-
solve(edge (Var (Id "X")) (Var (Id "Y")))
solve(edge (Atom "a") (Var (Id "Y")))
solve(edge (Var (Id "X")) (Atom "d"))
-}

