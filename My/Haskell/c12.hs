import System.IO

-- lookup2 :: Eq a => a -> [(a, b)] -> [(a, c)] -> Maybe (b, c)

-- lookupChain :: (Eq a, Eq b) => a -> [(a, b)] -> [(b, c)] -> Maybe (b, c)

-- andThen :: Maybe a -> (a -> Maybe b) -> Maybe b


-- tst :: [Int] -> Int -> Int
-- tst [] acc = acc
-- tst (h:t) acc = tst t (h+acc)
-- Debug.Trace



withFile' :: FilePath -> IOMode -> (Handle -> IO r) -> IO r
withFile' path mode f = do
    handle <- openFile path mode
    out <- f handle
    hClose handle
    pure out

main :: IO ()
main = do
    -- handle <- openFile "numbers.txt" WriteMode
    content <- readFile "numbers.txt"
    let ls = lines content
    let nums = map read ls
    let s = sum nums
    print s