--ex1 
--definir o Functor para o tipo abaixo:
data Tree a = Leaf | Node  (Tree a) a (Tree a) deriving Show

instance Functor Tree where
  --fmap :: (a -> b) -> Tree a -> Tree b
  -- folha -> retornamos folha novamente
  fmap _ Leaf = Leaf
  -- nó -> retornamos um outro nó com f aplicada nos ramos da esquerda
  -- e da direita, e no elemento central
  fmap f (Node l c r) = Node (fmap f l) (f c) (fmap f r)

--ex2

newtype ZipList a = Z [a] deriving Show

instance Functor ZipList where
    --fmap :: (a -> b) -> ZipList a -> ZipList b
    fmap g (Z xs) = Z $ map g xs

-- Dica: https://en.wikibooks.org/wiki/Haskell/Applicative_functors
-- dá pra entender muito mais fácil
instance Applicative ZipList where
    --pure :: a -> ZipList a
    pure x = Z $ repeat x

    --(<*>) :: ZipList (a -> b) -> ZipList a -> ZipList b
    (Z as) <*> (Z bs) = Z $ zipWith ($) as bs

--ex3
data Expr a = Var a | Val Int | Add (Expr a) (Expr a) deriving Show

instance Functor Expr where
    --fmap :: (a -> b) -> Expr a -> Expr b
    fmap = undefined

instance Applicative Expr where 
    --pure :: a -> Expr a
    pure = undefined

instance Monad Expr where
    --(>>=) :: Expr a -> (a -> Expr b) -> Expr b
    (>>=) = undefined 


--ex4 

newtype Identity a = Identity a

instance Functor Identity where
  fmap f (Identity a) = Identity (f a)

instance Applicative Identity where
  pure = Identity
  (Identity f) <*> (Identity a) = Identity (f a)

instance Monad Identity where
  (Identity a) >>= f = f a

data Pair a = Pair a a

instance Functor Pair where
  fmap f (Pair a b) = Pair (f a) (f b)

instance Applicative Pair where
  pure a = Pair a a
  (Pair f g) <*> (Pair a b) = Pair (f a) (g b)

-- Deve existir uma melhor maneira pra isso!
primeiro :: Pair a -> a
primeiro (Pair a _) = a

segundo :: Pair a -> a
segundo (Pair _ a) = a

instance Monad Pair where
  (>>=) = undefined -- Explode, porque iria fazer igual o prod. cartesiano da lista!
