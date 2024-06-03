data Tree = Nil | Node Tree Int Tree
  deriving (Eq, Ord, Show)

-- Returns all options how to get n as (a+b) where |b-a| <= 1
sumOptions :: Int -> [(Int, Int)]
sumOptions n
    | even n = [(half, half)]
    | otherwise = [(half, n - half), (n - half, half)]
    where half = n `div` 2

toTrees :: ([Tree], [Tree]) -> [Tree]
toTrees (ls, rs) = [Node l 0 r | l <- ls, r <- rs]

numberTree :: Tree -> Tree
numberTree tree = fst (numberTreeHelper 1 tree) where
    numberTreeHelper :: Int -> Tree -> (Tree, Int)
    numberTreeHelper n Nil = (Nil, n)
    numberTreeHelper n (Node l _ r) = (Node l_numbered l_out r_numbered, r_out) where
        (l_numbered, l_out) = numberTreeHelper n l
        (r_numbered, r_out) = numberTreeHelper (l_out + 1) r

allBalanced :: Int -> [Tree]
allBalanced 0 = [Nil]
allBalanced 1 = [Node Nil 1 Nil]
allBalanced n = map numberTree $ concatMap (toTrees . (\(a, b) -> (allBalanced a, allBalanced b))) (sumOptions (n-1))