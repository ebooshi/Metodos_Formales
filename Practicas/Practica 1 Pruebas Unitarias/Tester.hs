module Tester where

import Interpreter
import Test.QuickCheck

test1 n m = eval (Plus (Num n) (Num m)) == Num (n+m)
test2 n m = eval (Mul (Num n) (Num m)) == Num (n*m)

-- Esto falla
test3F n m = eval (Plus (Num n) (Num m)) == Num (n*m)

----------------------------------------------------------------------------------
-- Ejercicio 1)

-- Conmutatividad de la suma.
-- prop_sum_comm :: Int -> Int -> Bool
prop_sum_comm n m = eval (Plus (Num n) (Num m)) == eval (Plus (Num m) (Num n))

-- Inverso Aditivo.
-- prop_sum_inv :: Int -> Bool
prop_sum_inv n = eval(Plus (Num n) (Num (0-n))) == (Num 0)

-- Multiplicacion por 0.
-- prop_mul_zero :: Int -> Bool
prop_mul_zero n = eval(Mul (Num n) (Num 0)) == (Num 0)

-- Elemento Neutro
-- prop_sum_zero :: Int -> Bool
prop_sum_zero n = eval(Plus (Num n) (Num 0)) == (Num n)

-----------------------------------------------------------------------------------
-- Ejercicio 2)
-- Ill Formed Expresions (Sum, Gt)

prop_ill_sum_right b n = safe_eval(Plus (Boole b) (Num n))  == Nothing  ==> True

prop_ill_sum_left n b = safe_eval(Plus (Num n) (Boole b)) == Nothing ==> True

prop_ill_gt_right b n = safe_eval(Gt (Boole b) (Num n)) == Nothing ==> True

prop_ill_gt_left b n =safe_eval(Gt (Num n) (Boole b)) == Nothing ==> True

------------------------------------------------------------------------------------
--  Ejercicio 3)
--  Safe Let Implementation

prop_no_free_vars_val n m =  freeVars (Let (Var "s") (Num n) (Gt (Var "s") (Num m))) == [] ==> isValue (safe_eval(Let (Var "s") (Num n) (Gt (Var "s") (Num 2)))) == True
prop_free_vars_no_val n m =  freeVars (Let (Var "s") (Num n) (Gt (Var "t") (Num m))) /= [] ==> safe_eval(Let (Var "s") (Num n) (Gt (Var "t") (Num 2))) == Nothing

------------------------------------------------------------------------------------
-- Tarea, Ejercicio 2)
merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) | x <= y = x:merge xs (y:ys)
                    | otherwise = y:merge (x:xs) ys


msort :: Ord a => [a] -> [a]
msort [] = []
msort [a] = [a]
msort xs = merge (msort (firstHalf xs)) (msort (secondHalf xs))

firstHalf xs = let { n = length xs } in take (div n 2) xs
secondHalf xs = let { n = length xs } in drop (div n 2) xs


-- A)
prop_test_order :: [Int] -> Bool
prop_test_order xs = msort(xs) == msort(xs)

-- B)
prop_test_orig ::  [Int] -> Property
prop_test_orig xs = (length xs) == (length xs) ==> ( and_list( fmap (\x -> elem x xs') xs ) ) where xs' = msort xs 

and_list :: [Bool] -> Bool
and_list [] = True
and_list (x:xs) = x == (and_list xs)

-- C) 
prop_test_head::  [Int] -> Property
prop_test_head xs = length xs > 1 ==> (head xs') <= (minimum (tail xs')) where xs' = msort xs

----------------------------------
--Ejercicio 3
--isort = foldr insert []


--prop_isort_sort :: [Int] -> Bool
--prop_isort_sort xs = isort xs == sort xs

--prop_insert_ordered’ :: Int -> [Int] -> Bool
--prop_insert_ordered’ x xs = isOrdered (insert x xs)

-- Reparar si es por que no estaba ordenada
--prop_insert_ordered’ :: Int -> [Int] -> Bool
--prop_insert_ordered’ x xs = x > -1 ==>  isOrdered (insert x sort xs)

-- Preservacion de orden
--prop_insert_preserv :: Int -> [Int] -> Bool
--prop_insert_preserv x xs = isOrdered xs ==> isOrdered(insert x xs)