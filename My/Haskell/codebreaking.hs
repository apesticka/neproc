
import Data.Char

en_freq :: [Double]
en_freq = [8.2, 1.5, 2.8, 4.3, 12.7, 2.2, 2.0,
           6.1, 7.0, 0.2, 0.8, 4.0, 2.4, 6.7,
           7.5, 1.9, 0.1, 6.0, 6.3, 9.1, 2.8,
           1.0, 2.4, 0.2, 2.0, 0.1]

-- Calculates the 'value' of a character (from 0 to 25)
val :: Char -> Int
val c
    | isUpper c = ord c - 65
    | isLower c = ord c - 97

-- Decodes a char with a key
decodeChar :: Int -> Char -> Char
decodeChar key char
    | isUpper char = shift 'A'
    | isLower char = shift 'a'
    | otherwise = char
    where shift baseChar = chr ((ord char - base + key) `mod` 26 + base) where base = ord baseChar

-- Decodes a string with a key
decode :: String -> Int -> String
decode code key = map (decodeChar key) code

-- Decodes with all keys
decodeAll :: String -> [String]
decodeAll code = map (decode code) [0..25]

-- Calculates the number of occurences of each character
occurences :: String -> [Int]
occurences string = map (occurences_ string) [0..25]
    where occurences_ string value = length (filter (\c -> isAlpha c && val c == value) string)

-- How many alphabetical characters are in a string
charCount :: String -> Int
charCount string = length (filter isAlpha string)

-- Calculates the observed frequencies of a given string
observedFreq :: Int -> String -> [Double]
observedFreq count string = map (\x -> (fromIntegral x) / (fromIntegral count)) occ
    where occ = occurences string

-- Calculates the chi-squared statistic of a given string
stat :: Int -> [Double] -> String -> Double
stat count freq string = sum (zipWith (\o e -> ((o - e) ^ 2) / e) occ freq)
    where occ = observedFreq count string

-- Returns the string with the better statistic
compareStat :: Int -> [Double] -> String -> String -> String
compareStat count freq a b = if statA < statB then a else b
    where
        statA = stat count freq a
        statB = stat count freq b

crack :: [Double] -> String -> String
crack freq input = foldl (compareStat count f) input (decodeAll input)
    where
        count = charCount input
        f = map (/100) freq