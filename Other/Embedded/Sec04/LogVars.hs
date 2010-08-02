module LogVars where

import Control.Monad


newtype Id = Id String
    deriving (Eq)

data Term = Var Id | Atom String | Nil | Term:::Term
    deriving (Eq)

type Backtr a = [a]
type State    = (Subst, [Term])
type Subst    = [(Id, Term)]

newtype BS a = BS (State -> Backtr (State, a))
type Pred = BS ()


instance Monad BS where
    return a   = BS (\st -> return (st, a))
    BS f >>= k = BS (\st -> do (st', a) <- f st
                               let BS g = k a in g st')

instance MonadPlus BS where
    mzero             = BS (\st -> mzero)
    BS f `mplus` BS g = BS (\st -> f st `mplus` g st)


infix  8 =.
infixr 7 &.
infixr 6 |.

(=.) :: Term -> Term -> Pred
a =. b = BS (\(sub, vs) -> do sub' <- unify a b sub
                              return ((sub', vs), ()))

(&.), (|.) :: BS a -> BS a -> BS a
p &. q = p >> q
p |. q = p `mplus` q


true, false :: Pred
true  = return ()
false = mzero


free :: BS Term
free = BS (\(sub, v:vs) -> return((sub, vs), v))

exists :: (Term -> BS a) -> BS a
exists p = do a <- free
              p a


unify :: Term -> Term -> Subst -> Backtr Subst
unify (Var _)  (Var _)  = undefined
-- unify (Var i)  term     = \sub -> [(i, term):sub]
unify (Var i)  term     = \sub -> case lookup i sub of
                                    Nothing -> [(i, term):sub]
                                    Just t  -> if t == term then [sub]
                                                            else mzero
unify term     (Var i)  = unify (Var i) term
unify (Atom a) (Atom b) | a == b    = return
                        | otherwise = \_ -> mzero
unify _        _        = undefined
