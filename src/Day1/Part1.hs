module Day1.Part1 where

import Data.List (sort)
import Utils (toInt)

solution :: String -> String
solution input =
  show $ getDiffs 0 $ buildLists ([], []) $ map lineToTuple $ lines input

lineToTuple :: String -> (Maybe Int, Maybe Int)
lineToTuple line =
  case (words line) of
    [a, b] -> (toInt a, toInt b)
    _ -> (Nothing, Nothing)

buildLists :: ([Int], [Int]) -> [(Maybe Int, Maybe Int)] -> ([Int], [Int])
buildLists (l, r) [] = (sort l, sort r)
buildLists (lOut, rOut) ((Just l, Just r) : xs) = buildLists ([l] ++ lOut, [r] ++ rOut) xs
buildLists _ _ = ([], [])

getDiffs :: Int -> ([Int], [Int]) -> Int
getDiffs result ([], []) = result
getDiffs acc (l : ls, r : rs) = getDiffs ((+) acc $ abs $ l - r) (ls, rs)
getDiffs _ _ = 0