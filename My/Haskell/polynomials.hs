data Poly a = Poly [a]

stripLeadingZeros :: (Eq a, Num a) => [a] -> [a]
stripLeadingZeros [] = []
stripLeadingZeros (h:t)
    | h == 0    = stripLeadingZeros t
    | otherwise = h:t

instance (Eq a, Num a) => Eq (Poly a) where
    Poly a == Poly b = stripLeadingZeros a == stripLeadingZeros b

instance (Eq a, Num a, Show a) => Show (Poly a) where
    show (Poly []) = "0"
    show (Poly (p0:p)) = leadingMinus p0 ++ term p0 l ++ helper p (l - 1) where
        helper :: (Eq a, Num a, Show a) => [a] -> Int -> String
        helper [] (-1) = ""
        helper (h:t) c = sign h ++ term h c ++ helper t (c - 1)

        l = length p

        sign :: (Eq a, Num a, Show a) => a -> String
        sign x
            | x == 0     = ""
            | x == abs x = " + "
            | otherwise  = " - "

        coeff :: (Eq a, Num a, Show a) => a -> String
        coeff 0 = ""
        coeff 1 = ""
        coeff (-1) = ""
        coeff x = show (abs x)

        pow :: Int -> String
        pow 0 = ""
        pow 1 = "x"
        pow p = "x^" ++ show p

        term :: (Eq a, Num a, Show a) => a -> Int -> String
        term 0 _ = ""
        term x 0 = show (abs x)
        term x p = coeff x ++ pow p

        leadingMinus :: (Eq a, Num a, Show a) => a -> String
        leadingMinus x = if x == abs x then "" else "-"

instance (Eq a, Num a) => Num (Poly a) where
    Poly a + Poly b = poly (a `addP` b) where
        addP :: (Eq a, Num a) => [a] -> [a] -> [a]
        a `addP` b = reverse $ uncurry (zipWith (+)) $ pad (reverse a) (reverse b)

        -- Padds the shorter list with trailing zeros
        pad :: (Eq a, Num a) => [a] -> [a] -> ([a], [a])
        pad a b = if length a < length b
            then (a ++ map (const 0) [1..], b)
            else (a, b ++ map (const 0) [1..])

    Poly a * Poly b = poly $ map (sum . map (uncurry (*))) (pairs a b)

    negate (Poly p) = Poly $ map negate p

    fromInteger c = poly [fromInteger c]

    abs = id
    signum = const 1

poly :: (Eq a, Num a) => [a] -> Poly a
poly p = Poly $ stripLeadingZeros p



pairs :: [a] -> [b] -> [[(a, b)]]
pairs [] _ = []
pairs _ [] = []
pairs as bs = helper 0 as bs where

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
