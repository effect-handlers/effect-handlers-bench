{- Inversion of control -}
 
{-# LANGUAGE GADTs, TypeFamilies, MultiParamTypeClasses,
    FlexibleInstances, FlexibleContexts, QuasiQuotes, DeriveFoldable,
    BangPatterns #-}

import Prelude hiding (repeat)
import System.Environment
import HIA.Handlers
import HIA.TopLevel
import HIA.DesugarHandlers

[operation|Operator :: Int -> () |]

binop :: Int -> Int -> Int
binop !x !y = abs (x - (503 * y) + 37) `mod` 1009

[handler|
    HandleOperator :: Int
    handles {Operator} where
        Return x -> x
        Operator x k -> binop x (k ())
|]

type OperatorComp = Comp HandleOperator Int

loop :: Int -> Int -> OperatorComp
loop !0 !s = return s
loop !i !s = operator i >> loop (i - 1) s

run :: Int -> Int -> Int
run n s = handleOperator (loop n s)

repeat :: Int -> Int
repeat n = step 1000 0
           where step :: Int -> Int -> Int
                 step !0 !s = s
                 step !l !s = step (l - 1) (run n s)

main :: IO ()
main = do 
    args <- getArgs
    let n = case args of 
                [] -> 5
                n : _ -> read n :: Int

    let r = repeat n 
    putStrLn (show r) 
