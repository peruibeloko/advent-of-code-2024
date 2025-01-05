module Day3.Part2 where

import Utils (toInt, matchGroups)

mulPattern :: String
mulPattern = "mul\\(([0-9]+),([0-9]+)\\)"

doPattern :: String
doPattern = "do\\(\\)"

dontPattern :: String
dontPattern = "don't\\(\\)"

solution :: String -> String
solution input =
  show $ foldl (\out (a, b) -> out + a * b) 0 $ parse input

parse :: String -> [(Int, Int)]
parse input = map parseMult matches
  where
    inputString = foldl (<>) "" $ lines input
    matches = matchGroups mulPattern inputString

parseMult :: [String] -> (Int, Int)
parseMult input =
  case mapResult of
    [Just a, Just b] -> (a, b)
    _ -> (0, 0)
  where
    mapResult = map toInt input