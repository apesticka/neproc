import System.IO
import Data.Char
import Data.Array

parseChar :: Char -> Int
parseChar c = ord c - ord '0'

parseBoard :: String -> Array (Int, Int) Int
parseBoard content = array ((1, 1), (4, 4)) [((i, j), board !! (j - 1) !! (i - 1)) | i <- [1..4], j <- [1..4]] where
    lns = lines content
    board = map (map parseChar) lns

affected :: Int -> Int -> Array (Int, Int) Int -> [Int]
affected x y board = filter (/= 0) $
    [board ! (x, i) | i <- range' y] ++
    [board ! (i, y) | i <- range' x] ++
    [board ! diag x y]
    where
        range' i = [1..i-1] ++ [i+1..4]
        diag x y = (xtile + xmod, ytile + ymod) where
            xmod = x `mod` 2 + 1
            ymod = y `mod` 2 + 1
            xtile = ((x - 1) `div` 2) * 2
            ytile = ((y - 1) `div` 2) * 2

options :: Array (Int, Int) Int -> Int -> Int -> [Int]
options board x y = filter f [1..4] where
    f n = foldr ((&&).(/= n)) True (affected x y board)

boardConcatMap :: (Int -> Int -> [Int]) -> Array (Int, Int) Int -> [Array (Int, Int) Int]
boardConcatMap f arr = [arr // [((x, y), z)] |
                          x <- [1 .. 4],
                          y <- [1 .. 4],
                          let v = arr ! (x, y),
                          v == 0,
                          z <- f x y]

solve :: Array (Int, Int) Int -> [Array (Int, Int) Int]
solve board = if null step then [board] else concatMap solve step where
    step = boardConcatMap (options board) board

printBoard :: Array (Int, Int) Int -> IO ()
printBoard board = mapM_ putStrLn strRows where
    rows = [[board ! (x, y) | x <- [1..4]] | y <- [1..4]]
    strRows :: [String]
    strRows = map (map (\x -> chr (x + ord '0'))) rows

test =
    if any (==0) solved
        then putStrLn "no solution"
        else printBoard solved
    where
        board = parseBoard "3040\n0103\n2300\n4002"
        solved = head $ solve board

main :: IO ()
main = do
    content <- getContents
    let board = parseBoard content
    let solved = head $ solve board
    if any (==0) solved
        then putStrLn "no solution"
        else printBoard solved