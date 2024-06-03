-- data Extended = NegativeInfinity | Finite Integer | PositiveInfinity deriving (Show, Eq, Ord)
data Extended = NegativeInfinity | Finite Integer | PositiveInfinity deriving (Eq, Ord)

instance Show Extended where
    show NegativeInfinity = "-inf"
    show (Finite x)       = show x
    show PositiveInfinity = "+inf"

data ATree a = ALeaf | ANode (ATree a) a (ATree a) deriving (Show)
instance Eq a => Eq (ATree a) where
    ALeaf == ALeaf = True
    (ANode l1 x1 r1) == (ANode l2 x2 r2) = l1 == l2 && x1 == x2 && r1 == r2
    _ == _ = False

data BoolFn = BoolFn (Bool -> Bool)
instance Show BoolFn where
    show (BoolFn f) = "BoolFn (let f True = " ++ show (f True) ++ "; let f False = " ++ show (f False) ++ " in f)"

instance Eq BoolFn where
    (BoolFn f) == (BoolFn g) = f False == g False && f True == g True

class HasValue a where
    hasValue :: a -> Bool
    anyValue :: [a] -> Bool
    anyValue = any hasValue

instance HasValue (Maybe a) where
    hasValue Nothing = False
    hasValue (Just _) = True

leq :: Extended -> Extended -> Bool
leq _ PositiveInfinity = True
leq NegativeInfinity _ = True
leq (Finite x) (Finite y) = x <= y
leq _ _ = False



data Point = Point { getX :: Double, getY:: Double } deriving (Show, Eq)

-- data IntTree = IntLeaf | IntNode IntTree  Int IntTree deriving (Show, Eq)

data Tree a = Leaf | Node (Tree a) a (Tree a) deriving (Show, Eq)

contains :: Eq a => a -> Tree a -> Bool
contains _ Leaf = False
contains x (Node l y r) = x == y || contains x l || contains x r

containsBST :: Ord a => a -> Tree a -> Bool
containsBST _ Leaf = False
containsBST x (Node l y r) = case compare x y of
    LT -> containsBST x l
    EQ -> True
    GT -> containsBST x r



insert :: Ord a => a -> Tree a -> Tree a
insert x Leaf = Node Leaf x Leaf
insert x (Node l y r) = case compare x y of
    LT -> Node (insert x l) y r
    EQ -> Node l y r
    GT -> Node l y (insert x r)

removeLeftMost :: Tree a -> (a, Tree a)
removeLeftMost (Node Leaf x r) = (x, r)
removeLeftMost (Node l x r) = (y, Node l' x r) where (y, l') = removeLeftMost l

-- removeRightMost :: Tree a -> (a, Tree a)
-- removeRightMost (Node l x Leaf) = (x, l)
-- removeRightMost (Node l x r) = (y, Node l x r') where (y, r') = removeRightMost r

removeBSTRoot :: Tree a -> Tree a
removeBSTRoot (Node Leaf _ Leaf) = Leaf
removeBSTRoot (Node l x Leaf) = l
removeBSTRoot (Node l x r) = Node l y r' where (y, r') = removeLeftMost r

remove :: Ord a => a -> Tree a -> Tree a
remove x (Node Leaf y Leaf) = if x == y then Leaf else error "remove"
remove x (Node l y r) = case compare x y of
    LT -> Node (remove x l) y r
    EQ -> removeBSTRoot (Node l y r)
    GT -> Node l y (remove x r)