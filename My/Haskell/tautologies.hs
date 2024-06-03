import Data.List
import Data.Maybe

data Prop =
    Const Bool
  | Var Char
  | Not Prop
  | And Prop Prop
  | Or Prop Prop
  deriving Show

findVars :: Prop -> [Char]
findVars (Const bool)      = []
findVars (Var var)         = [var]
findVars (Not prop)        = findVars prop
findVars (And prop1 prop2) = findVars prop1 `union` findVars prop2
findVars (Or prop1 prop2)  = findVars prop1 `union` findVars prop2

generateModels :: [Char] -> [[(Char, Bool)]]
generateModels []         = [[]]
generateModels (var:vars) = map ((var, False):) submodels ++ map ((var, True):) submodels where
  submodels = generateModels vars

eval :: Prop -> [(Char, Bool)] -> Bool
eval (Const bool) _  = bool
eval (Var var) model = val where
  (_, val) = fromMaybe (var, True) $ find (\(chr, _) -> chr == var) model
eval (Not prop) model = not $ eval prop model
eval (And prop1 prop2) model = eval prop1 model && eval prop2 model
eval (Or prop1 prop2) model = eval prop1 model || eval prop2 model

isTaut :: Prop -> Bool
isTaut prop = all (prop `eval`) models where
  vars = findVars prop
  models = generateModels vars