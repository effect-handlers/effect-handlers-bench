{- Inversion of control -}
 
{-# LANGUAGE GADTs, TypeFamilies, MultiParamTypeClasses,
    FlexibleInstances, FlexibleContexts, QuasiQuotes, DeriveFoldable,
    BangPatterns #-}

import System.Environment
import HIA.Handlers
import HIA.TopLevel
import HIA.DesugarHandlers

[operation|Get s :: s |]
[operation|Put s :: s -> ()|]

[handler|
    EvalState s a :: s -> a
    handles {Get s,Put s} where
        Return x   _ -> x
        Get      k s -> (k s) s
        Put    s k _ -> (k ()) s 
|]

type CountdownComp = Comp (EvalState Int Int) Int

countdown :: CountdownComp
countdown = do
        y <- get
        if y == 0 then return y
        else do
            put (y - 1)
            countdown

run :: Int -> Int
run n = evalState n countdown

main :: IO ()
main = do 
    args <- getArgs
    let n = case args of 
                [] -> 5
                n : _ -> read n :: Int

    let r = run n 
    putStrLn (show r) 
