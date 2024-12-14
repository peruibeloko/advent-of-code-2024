module Day1.Part1 (solution) where

import Data.List (sort)
import Utils (imSure, toInt)

solution :: String -> String
solution input =
  show $ getDiffs 0 $ buildLists ([], []) $ map lineToTuple $ lines input

lineToTuple :: String -> (Maybe Integer, Maybe Integer)
lineToTuple line =
  case (words line) of
    [a, b] -> (toInt a, toInt b)

buildLists :: ([Integer], [Integer]) -> [(Maybe Integer, Maybe Integer)] -> ([Integer], [Integer])
buildLists (l, r) [] = (sort l, sort r)
buildLists (lOut, rOut) ((Just l, Just r) : xs) = buildLists ([l] ++ lOut, [r] ++ rOut) xs

getDiffs :: Integer -> ([Integer], [Integer]) -> Integer
getDiffs result ([], []) = result
getDiffs acc (l : ls, r : rs) = getDiffs ((+) acc $ abs $ l - r) (ls, rs)