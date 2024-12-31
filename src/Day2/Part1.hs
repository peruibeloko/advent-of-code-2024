module Day2.Part1 where

import Utils (imSure, toInt)

data Direction = Up | Down deriving (Eq)

solution :: String -> String
solution input =
  show $ length $ filter isSafeCall $ parse input

parse :: String -> [[Int]]
parse input =
  map (\line -> map (imSure . toInt) $ words line) (lines input)

diff :: Int -> Int -> Int
diff a b = abs $ a - b

direction :: Int -> Int -> Direction
direction a b | a < b = Up
direction a b | a > b = Down

withinBounds :: Int -> Int -> Bool
withinBounds a b = result >= 1 && result <= 3
  where
    result = diff a b

isSafeCall :: [Int] -> Bool
isSafeCall (x : xs) | x == head xs = False
isSafeCall (x : xs) | not $ withinBounds x $ head xs = False
isSafeCall (x : xs) = isSafe xs $ direction x $ head xs

isSafe :: [Int] -> Direction -> Bool
isSafe (a : b : []) prevDir = isSafeStep (a, b) prevDir
isSafe (x : xs) prevDir =
  if isCurrentSafe then isSafe xs currDir else False
  where
    isCurrentSafe = isSafeStep (x, head xs) prevDir
    currDir = (direction x $ head xs)

isSafeStep :: (Int, Int) -> Direction -> Bool
isSafeStep (a, b) _ | not $ withinBounds a b = False
isSafeStep (a, b) prevDir | (/=) prevDir $ direction a b = False
isSafeStep _ _ = True
