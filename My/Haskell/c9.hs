nebo :: Bool -> Bool -> Bool
nebo True _ = True
nebo False y = y

fns :: [Int -> Int]
fns = [(+2), (*3), (^2), (`div` 2)]

applyAll :: [a -> a] -> a -> a
applyAll fs x = foldr id x fs

insertAll :: a -> [a] -> [[a]]
insertAll x [] = [[x]]
insertAll x (h:t) = (x:h:t):(map (h:) (insertAll x t))

perm :: [a] -> [[a]]
perm [] = []
perm [x] = [[x]]
perm (x:xs) = foldr (++) [] (map (insertAll x) $ perm xs)

findMax :: [Int -> Int] -> Int -> Int
findMax fs x = maximum $ map (`applyAll` x) $ perm fs