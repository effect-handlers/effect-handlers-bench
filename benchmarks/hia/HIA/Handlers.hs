{- Open handlers -}

{-# LANGUAGE TypeFamilies,
    MultiParamTypeClasses,
    GADTs,
    TypeOperators,
    RankNTypes,
    FunctionalDependencies,
    PolyKinds
  #-}

module HIA.Handlers where

type family Return (opApp :: *) :: *
type family Result (h :: *) :: *
class ((h :: *) `Handles` (op :: j -> k -> *)) (e :: j) | h op -> e where
  clause :: op e u -> (Return (op e u) -> h -> Result h) -> h -> Result h
newtype Comp h a = Comp {handle :: (a -> h -> Result h) -> h -> Result h}
doOp :: (h `Handles` op) e => op e u -> Comp h (Return (op e u))
doOp op = Comp (\k h -> clause op k h)

instance Monad (Comp h) where
  return v     = Comp (\k h -> k v h)
  Comp c >>= f = Comp (\k h -> c (\x h' -> handle (f x) k h') h)

instance Applicative (Comp h) where
  pure    = return
  f <*> a = do {f' <- f; a' <- a; return (f' a')}

instance Functor (Comp h) where
  fmap f c = c >>= \x -> return (f x)
