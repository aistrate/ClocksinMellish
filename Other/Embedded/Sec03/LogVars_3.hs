module LogVars where

import Control.Monad
import Data.List (intercalate)
import Text.Printf (printf)


newtype Id = Id String
    deriving (Eq)

instance Show Id where
    show (Id i) = i


data Term = Var Id | Atom String | Nil | Term:::Term
    deriving (Eq)

instance Show Term where
    show (Var i)   = show i
    show (Atom a)  = a
    show  Nil      = "Nil"
    show (t1:::t2) = show t1 ++ ":::" ++ show t2


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


unify :: Term -> Term -> Subst -> Backtr Subst
unify (Var _)  (Var _)  = undefined
unify (Var i)  term     = \sub -> [(i, term):sub]
-- unify (Var i)  term     = \sub -> case lookup i sub of
--                                     Nothing -> [(i, term):sub]
--                                     Just _  -> mzero
unify term     (Var i)  = unify (Var i) term
unify (Atom a) (Atom b) | a == b    = return
                        | otherwise = \_ -> mzero
unify _        _        = undefined


infixr 6 |.
infixr 7 &.
infix  8 =.


(=.) :: Term -> Term -> Pred
a =. b = BS (\(sub, vs) -> do sub' <- unify a b sub
                              return ((sub', vs), ()))


(&.), (|.) :: Pred -> Pred -> Pred
p &. q = p >> q
p |. q = p `mplus` q


free :: BS Term
free = BS (\(sub, v:vs) -> return((sub, vs), v))


exists :: (Term -> BS a) -> BS a
exists p = do a <- free
              p a


true, false :: Pred
true  = return ()
false = mzero


-- Solving and printing the solutions
solve :: Pred -> IO ()
solve = printStates . query

solve1 :: Pred -> IO ()
solve1 = printStates1 . query

query :: Pred -> Backtr State
query p = let BS f = p 
          in fmap fst $ f ([], take 4 tempVars) 


tempVars = map (\i -> Var (Id i)) $ vars 1
    where vars :: Int -> [String]
          vars n = ("_G" ++ printf "%03d" n) : vars (n + 1)


printStates :: Backtr State -> IO ()
printStates [] = putStrLn "false\n"
printStates xs = do putStr . intercalate " ;\n\n" 
                             $ map showState xs
                    putStrLn " .\n"

printStates1 :: Backtr State -> IO ()
printStates1 [] = putStrLn "false\n"
printStates1 (x:xs) = do putStr $ showState x ++ " "
                         line <- getLine
                         putStrLn ""
                         if head line == ';' then printStates1 xs
                                             else return ()

showState :: State -> String
showState (subst, vars) = showSubst subst
    where showSubst = intercalate ",\n" . map showSubst1 . reverse
          showSubst1 (i, term) = (show i) ++ " = " ++ (show term)
