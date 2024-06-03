import Data.List

subsets :: [a] -> [[a]]
subsets list = concatMap finiteSubsets (inits list) where
    finiteSubsets :: [a] -> [[a]]
    finiteSubsets [] = [[]]
    finiteSubsets list = map (++ [l]) $ take (2^(length list - 1)) (subsets list) where
        l = last list


comb :: Int -> [a] -> [[a]]
comb 0 _ = [[]]
comb _ [] = []
comb n (h:t) = map (h:) (comb (n-1) t) ++ comb n t


combinations :: Int -> [a] -> [[a]]
combinations n list = concatMap (finiteCombinations n) (inits list) where
    finiteCombinations :: Int -> [a] -> [[a]]
    finiteCombinations n list
        | n > length list = []
        | otherwise = [c ++ [l] | c <- comb (n - 1) (init list)]
            where l = last list



pairs :: [a] -> [b] -> [(a, b)]
pairs as bs = concat $ helper 0 as bs where

    boundedLen :: Int -> [a] -> Int
    boundedLen = helper 0 where
        helper acc _ [] = acc
        helper acc n (_:t) = if acc >= n then n else helper (acc+1) n t

    _pairs :: [a] -> [b] -> Int -> [(a, b)]
    _pairs as bs 0 = [(head as, head bs)]
    _pairs as bs n = [(as !! i, bs !! (n-i)) | i <- [start..end]] where
        am = boundedLen (n+1) as - 1
        bm = boundedLen (n+1) bs - 1
        start = max 0 (n-bm)
        end = min am n

    helper counter as bs =
        if null p
        then []
        else p:helper (counter+1) as bs
            where p = _pairs as bs counter