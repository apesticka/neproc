import Data.List
import Data.Maybe

data Trie = TrieNode String [(Char, Trie)]

ahoCorasick :: [String] -> Trie
ahoCorasick = foldr addWord (TrieNode "" []) where
    addWord :: String -> Trie -> Trie
    addWord "" trie = trie
    addWord (wh:wt) (TrieNode "" []) = addWord wt (TrieNode [wh] [])
    addWord (wh:wt) (TrieNode val children)
        | isJust maybeChildIdx = let childIdx = fromJust maybeChildIdx in TrieNode val $ updateAtIndex childIdx (wh, addWord wt $ snd (children !! childIdx)) children
        | otherwise = TrieNode val $ (wh, addWord wt $ TrieNode (val ++ [wh]) []):children
        where
            maybeChildIdx = findIndex (\(char, _) -> char == wh) children

exampleTrie :: Trie
exampleTrie =
    TrieNode "a" [
        ('b', TrieNode "ab" [
            ('c', TrieNode "abc" [])
        ]),
        ('c', TrieNode "ac" [])
    ]

printLabeledTree :: Trie -> String
printLabeledTree (TrieNode value children) =
  value ++ concatMap printChild children
  where
    printChild (label, child) = " --" ++ show label ++ "--> " ++ printLabeledTree child


updateAtIndex :: Int -> a -> [a] -> [a]
updateAtIndex index newValue list = take index list ++ [newValue] ++ drop (index + 1) list