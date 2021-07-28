{- n-queens with a handler -}

{-# LANGUAGE GADTs, TypeFamilies, MultiParamTypeClasses,
    FlexibleContexts, TypeOperators, QuasiQuotes, BangPatterns #-}

import System.Environment

import HIA.Handlers
import HIA.TopLevel
import HIA.DesugarHandlers

[operation|Choose  :: Int -> Int|]
[operation|forall a.Fail :: a|]

-- This computation has been hoisted out of the below handler, because
-- HIA does not support bang patterns in handler definitions.
strictLoop :: Int -> Int -> Int -> (Int -> Int) -> Int
strictLoop n !i !acc resume
  = if i == n then (resume i) + acc
    else strictLoop n (i + 1) (resume i + acc) resume

[handler|
  CountSolutions :: Int handles {Choose, Fail} where
    Return x        -> 1
    Fail resume     -> 0
    Choose n resume -> strictLoop n 1 0 resume
|]

safe :: Int -> Int -> [Int] -> Bool
safe _ _ [] = True
safe queen diag (q : qs) = queen /= q
                           && queen /= q + diag
                           && queen /= q - diag
                           && safe queen (diag + 1) qs

findSolution :: ([handles|h {Choose}|], [handles|h {Fail}|]) => Int -> Int -> Comp h [Int]
findSolution !_ !0   = return []
findSolution n !col = do sol <- findSolution n (col - 1)
                         queen <- choose n
                         if safe queen 1 sol
                         then return (queen : sol)
                         else Main.fail

main :: IO ()
main = do args <- getArgs
          let n = case args of
                    []     -> 13
                    n' : _ -> read n' :: Int
          putStrLn (show (countSolutions (findSolution n n)))
