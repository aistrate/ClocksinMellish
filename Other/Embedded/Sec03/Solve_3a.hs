module Solve (solve, solve1) where

import Data.List (intercalate)
import Text.Printf (printf)
import LogVars


instance Show Id where
    show (Id i) = i

instance Show Term where
    show (Var i)   = show i
    show (Atom a)  = a
    show  Nil      = "Nil"
    show (t1:::t2) = show t1 ++ ":::" ++ show t2


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
