module Day1.Part2 where

import Data.List (sort)
import qualified Data.Map.Strict as Map
import Utils (frequencies, toInt)

solution :: String -> String
solution input =
  show
  $ getSimilarityScore 0
  $ getFrequencies
  $ buildLists ([], [])
  $ map lineToTuple
  $ lines input

lineToTuple :: String -> (Maybe Int, Maybe Int)
lineToTuple line =
  case (words line) of
    [a, b] -> (toInt a, toInt b)

buildLists :: ([Int], [Int]) -> [(Maybe Int, Maybe Int)] -> ([Int], [Int])
buildLists (l, r) [] = (sort l, sort r)
buildLists (lOut, rOut) ((Just l, Just r) : xs) = buildLists ([l] ++ lOut, [r] ++ rOut) xs

getFrequencies :: ([Int], [Int]) -> ([Int], Map.Map Int Int)
getFrequencies (ls, rs) = (ls, frequencies rs)

getSimilarityScore :: Int -> ([Int], Map.Map Int Int) -> Int
getSimilarityScore result ([], _) = result
getSimilarityScore score (l : ls, freqs) = getSimilarityScore newScore (ls, freqs)
  where
    newScore = case Map.lookup l freqs of
      Just v -> score + l * v
      Nothing -> score