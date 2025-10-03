module Day5.Part1 where

import Data.Map (Map, lookup)
import Data.List.Split (splitOn)
import qualified Data.IntMap as Map

type Rules = Map Int [Int]
type ParsedInput = (Rules, [[Int]])

solution :: String -> String
solution input = show $ sumMiddle $ filterValid $ parse input

parse :: String -> ParsedInput
parse input = (parseRules (lines rules) mempty, parsePages (lines pages))
  where
    (rules : pages) = splitOn "\n\n" input


filterValid :: ParsedInput -> [[Int]]
filterValid (rules, pages) =
  filter isUpdateValid pages
  where
    isUpdateValid update = all (== True) $ map (isPageValid update) update
    isPageValid update page =  map (\n -> n `elem` suffixes n) page
    suffixes n = Data.Map.lookup n rules

isValid :: Rules -> [Int] -> [Bool] -> [Bool]
isValid _ [] out = out
isValid rules (page : tail) out = out ++ (Map.lookup page )

sumMiddle :: [[Int]] -> Int
sumMiddle reports = sum $ map (!! 1) reports

parseRules :: [String] -> Rules -> Rules
parseRules [] output = output
parseRules rule output =
  Map.insert

parsePages :: [String] -> [[Int]]
parsePages input = map (map read . splitOn ",") input