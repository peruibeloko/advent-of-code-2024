module Day3.Part1 where

import Text.Regex.TDFA (getAllTextMatches, (=~))
import Utils (toInt)
import Debug.Trace (trace)

solution :: String -> String
solution input =
  show $ foldl (\out (a, b) -> out + a * b) 0 $ parse input
  where
    _ = trace $ show $ parse input

parse :: String -> [(Int, Int)]
parse input = map parseMult $ getAllTextMatches (inputString =~ "mul(\\d+,\\d+)")
  where
    inputString = foldl (<>) "" $ lines input

parseMult :: String -> (Int, Int)
parseMult input =
  case mapResult of
    [Just a, Just b] -> (a, b)
    _ -> (0, 0)
  where
    mapResult = map toInt stringNums
    stringNums = getAllTextMatches (input =~ "\\d+")