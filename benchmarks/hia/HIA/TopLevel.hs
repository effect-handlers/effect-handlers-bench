{- Top-level handlers -}

{-# LANGUAGE TypeFamilies,
    MultiParamTypeClasses,
    GADTs,
    TypeOperators,
    RankNTypes,
    FlexibleContexts,
    QuasiQuotes
  #-}

module HIA.TopLevel where

import HIA.Handlers
import HIA.DesugarHandlers

[handler|
  HandlePure a :: a handles {} where
    Return x -> x
|]
handlePure' :: (forall h.Comp h a) -> a
handlePure' c = handlePure c

[operation|forall a.Io :: IO a -> a|]
[handler|
  HandleIO a :: IO a handles {Io} where
    Return x -> return x
    Io m k   -> do {x <- m; k x}
|]
