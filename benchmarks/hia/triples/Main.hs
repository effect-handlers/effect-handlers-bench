{- Inversion of control -}
 
{-# LANGUAGE GADTs, TypeFamilies, MultiParamTypeClasses,
    FlexibleInstances, FlexibleContexts, QuasiQuotes, DeriveFoldable,
    BangPatterns #-}

import Prelude hiding (fail, flip)
import System.Environment
import HIA.Handlers
import HIA.TopLevel
import HIA.DesugarHandlers

[operation|Flip :: Bool|]
[operation|forall a. Fail :: a|]

[handler|
    HandleFlip :: Int
    handles {Flip, Fail} where
        Return x -> x
        Flip k   -> ((k True) + (k False)) `mod` 1000000007
        Fail k   -> 0
|]

type FlipComp = Comp HandleFlip Int

hash :: Int -> Int -> Int -> Int
hash a b c = (53 * a + 2809 * b + 148877 * c) `mod` 1000000007

choice :: Int -> FlipComp
choice !n | n < 1     = fail
          | otherwise = do x <- flip
                           if x then return n
                           else choice (n - 1)

triple :: Int -> Int -> FlipComp
triple n s = do i <- choice n
                j <- choice (i - 1)
                k <- choice (j - 1)
                if (i + j + k == s) then return (hash i j k)
                else fail

run :: Int -> Int -> Int
run n s = handleFlip (triple n s)

main :: IO ()
main = do 
    args <- getArgs
    let n = case args of 
                [] -> 10
                n : _ -> read n :: Int

    let r = run n n
    putStrLn (show r) 
