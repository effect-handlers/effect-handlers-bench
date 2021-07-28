{- Inversion of control -}

{-# LANGUAGE GADTs, TypeFamilies, MultiParamTypeClasses,
    FlexibleInstances, FlexibleContexts, QuasiQuotes, DeriveFoldable,
    BangPatterns #-}

import System.Environment

import Data.Foldable

import HIA.Handlers
import HIA.TopLevel
import HIA.DesugarHandlers

data Tree a = Leaf
            | Node (Tree a) a (Tree a)
            deriving Foldable

completeTree :: Int -> Tree Int
completeTree !0 = Leaf
completeTree !n = let t = completeTree (n - 1) in
                  Node t n t

[operation|Yield a :: a -> ()|]

newtype Generator a = Gen { runGen :: Maybe (a, Generator a) }

[handler|
  HandleYield a :: Generator a handles {Yield a} where
    Return x       -> Gen { runGen = Nothing }
    Yield v resume -> Gen { runGen = Just (v, resume ()) }
|]

makeGen :: Foldable t => t a -> Generator a
makeGen t = handleYield (forM_ t (\x -> yield x))

accumulate :: Generator Int -> Int
accumulate gen = loop 0 gen
  where loop !acc gen = case runGen gen of
                         Nothing -> acc
                         Just (x, next) -> loop (acc + x) next

main :: IO ()
main = do args <- getArgs
          let n = case args of
                    [] -> 25
                    n : _ -> read n :: Int
          let gen = makeGen (completeTree n)
          let result = accumulate gen
          putStrLn (show result)
