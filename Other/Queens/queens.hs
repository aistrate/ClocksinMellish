import Control.Monad
import Data.Function


fibs = fix ((0:) . (1:) . ap (zipWith (+)) tail)

{-
select :: [a] -> [(a, [a])]
select [] = fail []
select (x:xs) = (x, xs) : (map (\(a,b) -> (a, x:b)) (select xs))
-}

select :: [a] -> [(a, [a])]
select [] = []
select (x:xs) = (x, xs) :
                do (y, ys) <- select xs
                   return (y, x:ys)


nqueens:: Int -> [[Int]]
nqueens size = nqueens' [] [1..size]
    where nqueens' placedQueens [] = return placedQueens
          nqueens' placedQueens unplacedQueens =
                do (queen, newUnplacedQueens) <- select unplacedQueens
                   --True <- return (cannotAttack queen placedQueens)
                   guard $ cannotAttack queen placedQueens
                   nqueens' (queen:placedQueens) newUnplacedQueens
                   --let m = return (cannotAttack queen placedQueens)
                   --    f True  = nqueens' (queen:placedQueens) newUnplacedQueens
                   --    f False = []
                   --concatMap f m


cannotAttack :: Int -> [Int] -> Bool
cannotAttack row placedQueens = cannotAttack' row 1 placedQueens
    where cannotAttack' _row _n [] = True
          cannotAttack'  row  n (queen:placedQueens) =
                queen /= row + n &&
                queen /= row - n &&
                cannotAttack' row (n + 1) placedQueens


test = do i <- [1..10]
          True <- return True
          False <- return False
          return i
