import Data.List

rightMostSubstringIndex :: String -> String -> Int
rightMostSubstringIndex _  [] = -1
rightMostSubstringIndex str (h:t)
    | rest >= 0              = rest + 1
    | str `isPrefixOf` (h:t) = 0
    | otherwise              = -1
    where
        rest = str `rightMostSubstringIndex` t

step :: String -> String -> (Int, Int, Char)
step [] (a:left) = (0, 0, a)
step done left
    | idx < 0   = (0, 0, head left)
    | otherwise = (idx, length left, '$')
    where
        idx = left `rightMostSubstringIndex` done

prekomprese :: String -> [(Int, Int, Char)]
prekomprese = undefined