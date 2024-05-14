{- Inversion of control -}
 
{-# LANGUAGE GADTs, TypeFamilies, MultiParamTypeClasses,
    FlexibleInstances, FlexibleContexts, QuasiQuotes, DeriveFoldable,
    BangPatterns #-}

import System.Environment
import HIA.Handlers
import HIA.TopLevel
import HIA.DesugarHandlers

[operation|Emit :: Int -> () |]

-- Using parameter passing to maintain state, 
-- because no mutable variables
[handler|
    HandleEmit :: Int -> Int
    handles {Emit} where
        Return x s -> s
        Emit x k s -> (k ()) (s + x)
|]

type EmitComp = Comp HandleEmit Int

range :: Int -> Int -> EmitComp
range !l !u = if l > u 
                then return 0
                else do emit l; range (l + 1) u

run :: Int -> Int
run n = handleEmit 0 (range 0 n)

main :: IO ()
main = do 
    args <- getArgs
    let n = case args of 
                [] -> 5
                n : _ -> read n :: Int

    let r = run n 
    putStrLn (show r) 
