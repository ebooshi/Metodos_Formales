
module Interpreter where
import Data.List

type Var = String

data Exp = Num Int |
           Boole Bool |
           Plus Exp Exp | 
           Mul Exp Exp |
           Gt Exp Exp |
           Let Exp Exp Exp |
           Var String |
           If Exp Exp deriving(Show,Eq)

isValue :: Maybe Exp -> Bool
isValue (Just (Num _)) = True
isValue (Just (Boole _)) = True
isValue _ = False

isValue1 :: Exp -> Bool
isValue1 (Num _) = True
isValue1 (Boole _) = True
isValue1 _ = False

isVar :: Exp -> Bool
isVar (Var _) = True
isVar _ = False

vars :: Exp -> [Exp]
vars (Var s) = [(Var s)]
vars (Plus e1 e2) = vars e1 ++ vars e2
vars (Mul e1 e2) = vars e1 ++ vars e2
vars (Gt e1 e2) = vars e1 ++ vars e2
vars (If e1 e2) = vars e1 ++ vars e2
vars (Let e1 e2 e3) = vars e1 ++ vars e2 ++ vars e3
vars _ = []

boundVars :: Exp -> [Exp]
boundVars (Plus e1 e2) = (boundVars e1) ++ (boundVars e2)
boundVars (Mul e1 e2) = (boundVars e1) ++ (boundVars e2)
boundVars (Gt e1 e2) = (boundVars e1) ++ (boundVars e2)
boundVars (If e1 e2) = (boundVars e1) ++ (boundVars e2)
boundVars (Let e1 e2 e3) = [e1] ++ (boundVars e2) ++ (boundVars e3) 
boundVars _ = []

freeVars :: Exp -> [Exp]
freeVars e = (removeDuplicates (vars e)) \\ (removeDuplicates (boundVars e))

eval :: Exp -> Exp
eval (Num n) = Num n
eval (Boole b) = Boole b
eval (Plus e1 e2) = let e1' = eval e1
                        e2' = eval e2 in
                        case (e1',e2') of 
                            (Num n,Num m) -> Num (n+m)
eval (Mul e1 e2) = let e1' = eval e1
                       e2' = eval e2 in
                       case (e1',e2') of 
                        (Num n,Num m) -> Num (n*m)
eval (Gt e1 e2) = let e1' = eval e1
                      e2' = eval e2 in
                      case (e1',e2') of 
                        (Num n,Num m) -> Boole (n > m)

safe_eval :: Exp -> Maybe Exp
safe_eval (Num n) = Just (Num n)
safe_eval (Var s) = Just (Var s)
safe_eval (Boole b) = Just (Boole b)
safe_eval (Plus e1 e2) = let e1' = safe_eval e1
                             e2' = safe_eval e2 in
                        case (e1',e2') of
                         (Just (Num n), Just (Num m)) -> Just (Num (n+m))
                         (Just (Var s), Just (Var t)) -> Just (Plus (Var s) (Var t))
                         (Just (Var s), Just (Num t)) -> Just (Plus (Var s) (Num t))
                         (Just (Num s), Just (Var t)) -> Just (Plus (Num s) (Var t))
                         (_) -> Nothing
--                            (Just (Num m), Just (Var t)) -> Just (Plus (Num m) (t))
safe_eval (Mul e1 e2) = let e1' = safe_eval e1
                            e2' = safe_eval e2 in
                       case (e1',e2') of 
                        (Just (Num n), Just (Num m)) -> Just (Num (n*m))
                        (Just (Var s), Just (Var t)) -> Just (Mul (Var s) (Var t))
                        (Just (Var s), Just (Num t)) -> Just (Mul (Var s) (Num t))
                        (Just (Num s), Just (Var t)) -> Just (Mul (Num s) (Var t))
                        (_) -> Nothing
safe_eval (Gt e1 e2) = let e1' = safe_eval e1
                           e2' = safe_eval e2 in
                      case (e1',e2') of 
                        (Just (Num n), Just (Num m)) -> Just (Boole (n > m))
                        (Just (Var s), Just (Var t)) -> Just (Gt (Var s) (Var t))
                        (Just (Var s), Just (Num t)) -> Just (Gt (Var s) (Num t))
                        (Just (Num s), Just (Var t)) -> Just (Gt (Num s) (Var t))
                        (_) -> Nothing
safe_eval (Let e1 e2 e3) = if (freeVars (Let e1 e2 e3) == [] && isValue1 e2 && isVar e1) then (safe_eval (subst e1 e2 e3)) else Nothing


subst :: Exp -> Exp -> Exp -> Exp
subst (Var s) e1 (Num x) = (Num x)
subst (Var s) e1 (Boole b) = (Boole b)
subst (Var s) e1 (Var t) = if s == t then e1 else (Var t)
subst (Var s) (Num n) (Plus (Var t) (Num m)) = if s == t then Plus (Num n) (Num m) else (Plus (Var t) (Num m))
subst (Var s) (Num n) (Plus (Num m) (Var t)) = if s == t then Plus (Num m) (Num n) else (Plus (Num m) (Var t))
subst (Var s) (Num n) (Mul (Var t) (Num m)) = if s == t then Mul (Num n) (Num m) else (Mul (Var t) (Num m))
subst (Var s) (Num n) (Mul (Num m) (Var t)) = if s == t then Mul (Num m) (Num n) else (Mul (Num m) (Var t))
subst (Var s) (Num n) (Gt (Var t) (Num m)) = if s == t then Gt (Num n) (Num m) else (Gt (Var t) (Num m))
subst (Var s) (Num n) (Gt (Num m) (Var t)) = if s == t then Gt (Num m) (Num n) else (Gt (Num m) (Var t))


removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates = rdHelper []
    where rdHelper seen [] = seen
          rdHelper seen (x:xs)
              | x `elem` seen = rdHelper seen xs
              | otherwise = rdHelper (seen ++ [x]) xs

-- Tomada prestada de:
-- https://stackoverflow.com/questions/16108714/removing-duplicates-from-a-list-in-haskell-without-elem
