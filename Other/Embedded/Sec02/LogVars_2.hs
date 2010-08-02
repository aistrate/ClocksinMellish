-- {-# LANGUAGE TypeSynonymInstances #-}

module LogVars where

import Control.Monad (mzero)
import Data.List (intercalate)


newtype Id = Id String
    deriving (Eq)

instance Show Id where
    show (Id i) = ":" ++ i


data Term = Var Id | Atom String | Nil | Term:::Term
    deriving (Eq)

instance Show Term where
    show (Var i)  = show i
    show (Atom a) = a
    show  t       = ".[" ++ showLst t

showLst :: Term -> String
showLst  Nil      = "]."
showLst (t:::Nil) = show t ++ "]."
showLst (t1:::t2) = show t1 ++ showLst2 t2
    where showLst2 t@(_:::_) = "," ++ showLst t
          showLst2 t         = "|" ++ show t ++ "]."
--showLst  t        = "|" ++ show t ++ "]."

{-
show (Var (Id "X"))
show (Atom "a")
show Nil
show $ (Atom "b"):::Nil
show $ (Atom "b"):::((Atom "c"):::Nil)
show $ (Atom "b"):::((Var (Id "Y")):::Nil)
show $ (Atom "b"):::(Var (Id "Y"))
show $ (Atom "b"):::((Atom "c"):::(Var (Id "Y")))
show $ (Atom "b"):::((Atom "c"):::((Var (Id "Y")):::Nil))
show $ Nil:::Nil
show $ Nil:::(Atom "b")
show $ Nil:::((Atom "b"):::Nil)
show $ Nil:::(Var (Id "Y"))
-}


type Backtr a = [a]
type Pred     = State -> Backtr State
type State    = (Subst, [Term])
type Subst    = [(Id, Term)]



unify :: Term -> Term -> Subst -> Backtr Subst
unify (Var _)  (Var _)  = undefined
unify (Var i)  term     = \sub -> [(i, term):sub]
unify term     (Var i)  = unify (Var i) term
unify (Atom a) (Atom b) | a == b    = return
                        | otherwise = \_ -> mzero
unify x        y        = \sub -> [(Id "XXX", x):(Id "YYY", y):sub]
--unify _        _        = undefined



infixr 6 |.
infixr 7 &.
infix  8 =.


(=.) :: Term -> Term -> Pred
a =. b = \(sub, vs) -> do sub' <- unify a b sub; return (sub', vs)

(&.), (|.) :: Pred -> Pred -> Pred
p &. q = \st -> p st >>= q
p |. q = \st -> p st ++ q st

exists :: (Term -> Pred) -> Pred
-- exists p = \(sub, v:vs) -> p v (sub, vs)
exists p (sub, [])   = mzero
exists p (sub, v:vs) = p v (sub, vs)

true, false :: Pred
true = \st -> return st
false = \st -> mzero


query :: Pred -> Backtr State
query p = p ([], [])

runQuery :: Pred -> IO ()
runQuery = printStates . query

printStates :: Backtr State -> IO ()
printStates = mapM_ (putStrLn . showState)

showState :: State -> String
showState (subst, vars) = showSubst subst ++ ";\n" 
                          -- ++ show vars ++ "\n"
    where showSubst = intercalate ",\n" . map showSubst1
          showSubst1 (i, term) = (show i) ++ " = " ++ (show term)
