{- Inversion of control -}
 
{-# LANGUAGE GADTs, TypeFamilies, MultiParamTypeClasses,
    FlexibleInstances, FlexibleContexts, QuasiQuotes, DeriveFoldable,
    BangPatterns #-}

import System.Environment

-- Imports are not needed, but included so that
-- all benchmarking tests have the same import overhead
import HIA.Handlers
import HIA.TopLevel
import HIA.DesugarHandlers

fib :: Int -> Int
fib !0 = 0
fib !1 = 1
fib !n = fib (n - 1) + fib (n - 2)

main :: IO ()
main = do 
    args <- getArgs
    let n = case args of 
                [] -> 5
                n : _ -> read n :: Int

    let r = fib n 
    putStrLn (show r) 
