{- n-queens with a handler -}

{-# LANGUAGE GADTs, TypeFamilies, RankNTypes,
    MultiParamTypeClasses, FlexibleInstances, OverlappingInstances,
    FlexibleContexts, UndecidableInstances, TypeOperators,
    QuasiQuotes
  #-}

import System.Environment

import Control.Monad
import Control.Applicative
import Data.Maybe

import HIA.Handlers
import HIA.TopLevel
import HIA.DesugarHandlers

[operation|forall a.Choose  :: [a] -> a|]

[handler|
  HandleChoose a :: Maybe a handles {Choose} where
    Return x    -> Just x
    Choose xs k -> loop xs
       where loop      []  = Nothing
             loop (x : xs) = case k x of
                               Nothing    -> loop xs
                               r@(Just _) -> r
|]

noAttack :: Int -> Int -> (Int, Int) -> Bool
noAttack x y (x', y')
  = x /= x' && y /= y' && abs (x - x') /= abs (y - y')

available :: Int -> [(Int,Int)] -> [Int] -> [Int]
available x qs l = filter (\y -> all (noAttack x y) qs) l

findSolution :: [handles|h {Choose}|] => Int -> Comp h [(Int, Int)]
findSolution n = place 1 [] [1..n]
  where place x qs l = if x == n + 1
                       then return qs
                       else do y <- choose (available x qs l)
                               place (x + 1) ((x, y) : qs) l

main :: IO ()
main = do args <- getArgs
          let n = case args of
                    []     -> 8
                    n' : _ -> read n' :: Int
          case handleChoose (findSolution n) of
             Nothing -> putStrLn "No solution found"
             Just xs ->
                do forM_ xs (\(x,y) -> putStr ("(" ++ show x ++ "," ++ show y ++ ") "))
                   putStrLn ""
