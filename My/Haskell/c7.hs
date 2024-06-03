pythd :: Double -> Double -> Double
pythd a b = sqrt (a * a + b * b)

-- [x * x | x <- [1, 2, 3]]

-- findPyth 10 = [(3, 4, 5)]

pyth :: (Int, Int, Int) -> Bool
pyth (a, b, c) = (a * a + b * b == c * c)

findPyth :: Int -> [(Int, Int, Int)]
findPyth n = filter pyth [(a, b, c) | a <- [1..n], b <- [a..n], c <- [b..n]]

isInt :: Double -> Bool
isInt x = (x == fromIntegral (floor x))

pyth2 :: Int -> Int -> Int
pyth2 a b = undefined