import Data.List

pow :: Int -> (a -> a) -> (a -> a)
pow 1 f = f
pow n f = f.pow (n-1) f

add :: Int -> Int -> Int
add a b = pow a succ b

mult :: Int -> Int -> Int
mult a b = pow a (add b) 0

exp :: Int -> Int -> Int
exp a b = pow b (mult a) 1

-- split :: [a] -> [([a], [a])]
-- split [] = []
-- split (h:t) = ([],h:t):(([h], t):map (\(a,b) -> (h:a,b)) (split t))

split :: [a] -> [([a], [a])]
split l = zip (inits l) (tails l)