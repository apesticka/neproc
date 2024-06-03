
impl :: Bool -> Bool -> Bool
impl a b = not a || b

is_equiv :: (a -> a -> Bool) -> [a] -> Bool
is_equiv rel set = and
    [
        (rel x x) &&
        (rel x y `impl` rel y x) &&
        ((rel x y && rel y z)  `impl` rel x z) |
        x <- set, y <- set, z <- set
    ]

addToCorrectClass :: (a -> a -> Bool) -> [[a]] -> a -> [[a]]
addToCorrectClass rel [] x = [[x]]
addToCorrectClass rel (cl:acc) x
    | rel (head cl) x = ((x:cl):acc)
    | otherwise = cl:addToCorrectClass rel acc x

classes :: (a -> a -> Bool) -> [a] -> [[a]]
classes rel set = foldl (addToCorrectClass rel) [] set

reflexive_closure :: Eq a => (a -> a -> Bool) -> (a -> a -> Bool)
reflexive_closure rel a b
    | a == b = True
    | otherwise = a `rel` b