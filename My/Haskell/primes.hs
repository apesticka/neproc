
smallestFactorGTE :: Int -> Int -> Int
smallestFactorGTE bound n = if list == []
    then n
    else head list
    where root = floor (sqrt (fromIntegral n))
          list = [x | x <- [bound..root], n `mod` x == 0]

factorsR :: Int -> Int -> [Int] -> [Int]
factorsR n bound acc = if last < n
    then factorsR (n `div` last) last (last:acc)
    else last:acc
    where last = smallestFactorGTE bound n

factors :: Int -> [Int]
factors n = reverse (factorsR n 2 [])

findDivisor :: Int -> [Int] -> Bool
findDivisor _ [] = False
findDivisor n list = n `mod` h == 0 || findDivisor n t
    where (h:t) = list


-- prime :: [Int] -> Int -> [Int]
-- prime primes n = if not (findDivisor n primes)
--     then n:primes
--     else primes

-- primes :: Int -> [Int]
-- primes n = reverse (foldl prime [] [2..n])

prime :: Int -> Bool
prime n = [n] == factors n

primes :: Int -> [Int]
primes n = [x | x <- [2..n], prime x]

consec :: [Int] -> [(Int, Int)]
consec list = case list of
    [] -> []
    [x] -> []
    [x, y] -> [(x, y)]
    (x:y:rest) -> (x, y) : consec (y:rest)

comparePair :: (Int, Int) -> (Int, Int) -> (Int, Int)
comparePair (a, b) (c, d) = if d - c > b - a then (c, d) else (a, b) 

gap :: Int -> (Int, Int)
gap n = foldl comparePair (2, 3) (consec (primes n))
