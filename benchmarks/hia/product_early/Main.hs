{- Inversion of control -}
 
{-# LANGUAGE GADTs, TypeFamilies, MultiParamTypeClasses,
    FlexibleInstances, FlexibleContexts, QuasiQuotes, DeriveFoldable,
    BangPatterns #-}

import System.Environment
import HIA.Handlers
import HIA.TopLevel
import HIA.DesugarHandlers

[operation|forall b.Done a :: a -> b |]

[handler|
    HandleDone a :: a
    handles {Done a} where
        Return x -> x
        Done x k -> x
|]

type EarlyComp = Comp (HandleDone Int) Int

product' :: [Int] -> EarlyComp
product' []     = return 0
product' (0:ys) = done 0
product' (y:ys) = do x <- product' ys; return (y * x)

-- Accept an extra parameter to make GHC execute `runProduct` more than once.
-- Prevent inlining so that GHC cannot tell we're doing this.
{-# NOINLINE runProduct #-}
runProduct :: [Int] -> Int -> Int
runProduct xs _ = handleDone (product' xs)

enumerate :: Int -> [Int]
enumerate !i | i < 0 = []
             | otherwise = i : enumerate (i - 1)

run :: Int -> Int
run n = loop n 0
        where xs = enumerate 1000
              loop :: Int -> Int -> Int
              loop !0 !a = a
              loop !i !a = loop (i - 1) (a + runProduct xs a)

main :: IO ()
main = do 
    args <- getArgs
    let n = case args of 
                [] -> 5
                n : _ -> read n :: Int

    let r = run n 
    putStrLn (show r) 
