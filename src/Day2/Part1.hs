module Day2.Part1 where

import Utils (imSure, toInt)

data Direction = Up | Down deriving (Eq)

solution :: String -> String
solution input =
  show $ length $ filter isReportSafe $ parse input

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

isReportSafe :: [Int] -> Bool
isReportSafe (x : xs) | x == head xs = False
isReportSafe (x : xs) | not $ withinBounds x $ head xs = False
isReportSafe (x : xs) = isReportSafeRecursion xs $ direction x $ head xs

isReportSafeRecursion :: [Int] -> Direction -> Bool
isReportSafeRecursion (a : b : []) prevDir = isReadingSafe (a, b) prevDir
isReportSafeRecursion (x : xs) prevDir =
  if isCurrentSafe then isReportSafeRecursion xs currDir else False
  where
    isCurrentSafe = isReadingSafe (x, head xs) prevDir
    currDir = (direction x $ head xs)

isReadingSafe :: (Int, Int) -> Direction -> Bool
isReadingSafe (a, b) _ | not $ withinBounds a b = False
isReadingSafe (a, b) prevDir | (/=) prevDir $ direction a b = False
isReadingSafe _ _ = True
