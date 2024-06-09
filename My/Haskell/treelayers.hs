import Data.Map as Map
import Data.Set as Set
import Data.Maybe

insertEdge :: Ord a => a -> a -> Map a (Set a) -> Map a (Set a)
insertEdge key val tree = Map.insert key newList tree where
    newList = Set.insert val $ fromMaybe (Set.empty :: Set a) (Map.lookup key tree)

toTree :: Ord a => [(a, a)] -> Map a (Set a)
toTree [] = Map.empty
toTree ((u, v):edges) =
    let rest = toTree edges in
    let firstInsert = insertEdge u v rest in
    insertEdge v u firstInsert

removeEdges :: Ord a => Map a (Set a) -> Map a (Set a) -> Map a (Set a)
removeEdges edges tree = Map.foldrWithKey helper tree edges where
    helper u set tree =
        let v = Set.findMin set in
        -- u is the leaf, v is the other vertex
        let oldSet = fromMaybe Set.empty $ Map.lookup v tree in
        let newSet = Set.delete u oldSet in
        Map.insert v newSet tree

leaves :: Ord a => Map a (Set a) -> ([a], Map a (Set a))
leaves tree
    | Map.size tree <= 2 = (Map.keys tree, Map.empty)
    | otherwise = 
    let (leavs, rest) = Map.partition ((<=1).Set.size) tree in
    let updated = removeEdges leavs rest in
    let list = Map.keys leavs in
    (list, updated)

layers :: Ord a => Map a (Set a) -> [[a]]
layers tree
    | Map.size rest == 0 = [layer]
    | otherwise          = layer:layers rest
    where
        (layer, rest) = leaves tree

vrstvy :: Ord a => [(a, a)] -> [[a]]
vrstvy = layers.toTree