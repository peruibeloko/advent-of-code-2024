module Day3.Part1 where

import Utils (matchGroups, toInt)

mulPattern :: String
mulPattern = "mul\\(([0-9]+),([0-9]+)\\)"

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