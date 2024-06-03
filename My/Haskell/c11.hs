import Data.Monoid

data Tree a = Leaf | Node (Tree a) a (Tree a)

class HasValue a where
    hasValue :: a -> Bool

class Collection c where
    toList :: c a -> [a]

    contains :: Eq a => a -> c a -> Bool
    contains x c = x `elem` toList c

instance Collection [] where
    toList = id

instance Functor Tree where
    fmap f Leaf = Leaf
    fmap f (Node l x r) = Node (fmap f l) (f x) (fmap f r)

instance Semigroup Int where
    (<>) = (+)

instance Monoid Int where
    mempty = 0

-- newtype Sum a = Sum { getSum :: a } deriving Show
-- newtype Product a = Product { getProduct :: a } deriving Show

-- instance Num a => Semigroup (Sum a) where
--     Sum a <> Sum b = Sum (a + b)

instance Foldable Tree where
    foldMap f Leaf = mempty
    foldMap f (Node l x r) = foldMap f l <> f x <> foldMap f r


length' :: Foldable t => t a -> Int
length' foldable = getSum $ foldMap (const $ Sum (1 :: Int)) foldable

sum' :: (Foldable t, Num a) => t a -> a
sum' foldable = getSum $ foldMap Sum foldable

product' :: (Foldable t, Num a) => t a -> a
product' foldable = getProduct $ foldMap Product foldable

toList' :: Foldable t => t a -> [a]
toList' = foldMap (:[])


-- newtype Sth a = Sth { getSth :: a } deriving Show
-- instance Semigroup Sth where
--     (<>) = 

-- foldr' :: Foldable t => (a -> b -> b) -> b -> t a -> b
-- foldr' f acc foldable = 

