import Data.List
import Data.Char

arrSum :: [[Int]] -> [Int]
arrSum = foldr (zipWith (+)) [0,0..]

searchRow :: String -> [String] -> [Int]
searchRow row = map (oneRowOneWord row) where
    oneRowOneWord :: String -> String -> Int
    oneRowOneWord "" _ = 0
    oneRowOneWord row word
        | word `isPrefixOf` row = 1 + oneRowOneWord (tail row) word
        | otherwise = oneRowOneWord (tail row) word

searchRows :: [String] -> [String] -> [Int]
searchRows table words = arrSum $ map (`searchRow` words) table

search :: [String] -> [String] -> [Int]
search table words = arrSum [searchRows tableLower wordsLower, searchRows tableLower wordsR, searchRows tableT wordsLower, searchRows tableT wordsR] where
    wordsLower = map (map toLower) words
    tableLower = map (map toLower) table
    wordsR = map reverse wordsLower
    tableT = transpose tableLower