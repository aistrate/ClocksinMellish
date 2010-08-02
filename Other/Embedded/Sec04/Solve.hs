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


solve :: Show a => BS a -> IO ()
solve = printStates . query

solve1 :: Show a => BS a -> IO ()
solve1 = printStates1 . query


query :: BS a -> Backtr (State, a)
query p = let BS f = p 
          in f ([], take 10 tempVars) 

tempVars = map (\i -> Var (Id i)) $ vars 1
    where vars :: Int -> [String]
          vars n = ("_G" ++ printf "%03d" n) : vars (n + 1)


printStates :: Show a => Backtr (State, a) -> IO ()
printStates [] = putStrLn "false\n"
printStates xs = do putStr . intercalate " ;\n\n" 
                           $ map showState xs
                    putStrLn " .\n"

printStates1 :: Show a => Backtr (State, a) -> IO ()
printStates1 [] = putStrLn "false\n"
printStates1 (x:xs) = do putStr $ showState x ++ " "
                         line <- getLine
                         putStrLn ""
                         if head line == ';' then printStates1 xs
                                             else return ()

showState :: Show a => (State, a) -> String
showState ((subs, vs), res) = subsStr ++
                              if show res == "()"
                                  then ""
                                  else let nl = if subsStr == "" then "" else "\n"
                                       in nl ++ "   => " ++ show res
    where subsStr = intercalate ",\n" . map showSub . reverse $ subs
          showSub (i, term) = (show i) ++ " = " ++ (show term)
