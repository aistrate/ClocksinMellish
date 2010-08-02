import LogVars
import Solve


path :: Term -> Term -> BS Term
path x z =  do x =. z
               return (x ::: Nil)
         |. do y <- neighbour x
               nodes <- path y z
               return (x ::: nodes)

{-
solve(path (Atom "a") (Atom "a"))
solve(path (Atom "a") (Atom "b"))
solve(path (Atom "a") (Atom "e"))
-}


neighbour :: Term -> BS Term
neighbour x = do y <- free
                 edge x y
                 return y

{-
solve(neighbour(Atom "a"))
solve(neighbour(Atom "e"))
solve(neighbour(Var (Id "X")))
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
