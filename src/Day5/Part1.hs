module Day5.Part1 where

import Data.IntMap.Strict (IntMap)
import qualified Data.IntMap.Strict as Map

import Data.Set (Set)
import qualified Data.Set as Set

import Data.List.Split (splitOn)
import Data.Maybe (fromMaybe)
import Utils (debug)
import Prelude hiding (lookup)

type Page = Int
type Update = [Page]
type Rules = IntMap (Set Page)
type ParsedInput = (Rules, [Update])

solution :: String -> String
solution input = show $ sumMiddle $ filterValid $ parse input
  where

parse :: String -> ParsedInput
parse input = (parseRules rules Map.empty, pages)
  where
    (rawRules : rawPages : _) = splitOn "\n\n" input
    rules = map tuple $ map (map read . splitOn "|") $ lines rawRules
    pages = map (map read . splitOn ",") $ lines rawPages
    tuple (a : b : _) = (a, b)

parseRules :: [(Int, Int)] -> Rules -> Rules
parseRules [] output = output
parseRules ((base, suffix) : rest) output =
  case Map.lookup base output of
    Just s -> parseRules rest $ Map.insert base (Set.insert suffix s) output
    Nothing -> parseRules rest $ Map.insert base (Set.fromList [suffix]) output

filterValid :: ParsedInput -> [Update]
filterValid (rules, updates) = filter (isUpdateValid rules []) updates

isUpdateValid :: Rules -> [Bool] -> Update -> Bool
isUpdateValid _ out [] = and out
isUpdateValid rules out (page : rest) =
  isUpdateValid rules (out ++ [checkTail]) rest
  where
    getSuffixes page = fromMaybe Set.empty $ Map.lookup page rules
    checkTail = and $ map (\m -> Set.member m (getSuffixes page)) rest

sumMiddle :: [Update] -> Int
sumMiddle updates = sum $ map getMiddle updates
  where
    midpoint update = length update `div` 2
    getMiddle update = head $ drop (midpoint update) update