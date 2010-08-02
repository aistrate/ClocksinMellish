import LogVars


path :: Term -> Term -> Term -> Pred
path x z nodes = do x =. z
                    nodes =. x ::: Nil
              |. do nodes' <- free
                    nodes =. x ::: nodes'
                    y <- free
                    edge x y
                    path y z nodes'

{-
solve(path (Atom "a") (Atom "a") (Var (Id "Nodes")))
solve(path (Atom "a") (Atom "b") (Var (Id "Nodes")))
solve(path (Atom "a") (Atom "e") (Var (Id "Nodes")))
-}


edge :: Term -> Term -> Pred
edge x y = foldr (|.) false [ x =. Atom a &. y =. Atom b | (a, b) <- graph ]
    where graph = [ ("a", "b"), ("a", "d"), ("b", "c"), ("b", "d"),
                    ("c", "d"), ("c", "e"), ("d", "e") ]

{-
solve(edge (Var (Id "X")) (Var (Id "Y")))
solve(edge (Atom "a") (Var (Id "Y")))
solve(edge (Var (Id "X")) (Atom "d"))
-}
