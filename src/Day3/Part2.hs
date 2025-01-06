module Day3.Part2 where

import Data.List (sortBy)
import Utils (matchAllIndexed, matchGroups, toInt)

data Instruction = Mult Int Int | Enable | Disable

data EvalState = On | Off

type TaggedMatch = (String, [(String, Int)])

multPattern :: String
multPattern = "mul\\(([0-9]+),([0-9]+)\\)"

doPattern :: String
doPattern = "do\\(\\)"

dontPattern :: String
dontPattern = "don't\\(\\)"

reservedWords :: [(String, String)]
reservedWords = [(multPattern, "Mult"), (doPattern, "Enable"), (dontPattern, "Disable")]

solution :: String -> String
solution input =
  show $
    foldl (+) 0 $
      evaluateList On [] $
        map (\(el, _) -> el) $
          sortBy (\(_, a) (_, b) -> compare a b) $
            parseInstructions inputString
  where
    inputString = foldl (<>) "" $ lines input

parseMult :: String -> Instruction
parseMult input =
  case groups of
    [Just a, Just b] -> Mult a b
    _ -> Mult 0 0
  where
    groups = map toInt $ map head $ matchGroups multPattern input

parseMatch :: TaggedMatch -> [(Instruction, Int)]
parseMatch ("Enable", ops) = map (\(_, idx) -> (Enable, idx)) ops
parseMatch ("Disable", ops) = map (\(_, idx) -> (Disable, idx)) ops
parseMatch ("Mult", ops) = map (\(content, idx) -> (parseMult content, idx)) ops

parseInstructions :: String -> [(Instruction, Int)]
parseInstructions input = concatMap parseMatch matches
  where
    matchAndTag = \(pattern, label) -> (label, matchAllIndexed pattern input)
    matches = map matchAndTag reservedWords

evaluateList :: EvalState -> [Int] -> [Instruction] -> [Int]
evaluateList _ output [] = output
evaluateList Off output (Enable : rest) = evaluateList On output rest
evaluateList Off output (_ : rest) = evaluateList Off output rest
evaluateList On output (curr : rest) =
  case curr of
    Mult a b -> evaluateList On ((a * b) : output) rest
    Disable -> evaluateList Off output rest
    Enable -> evaluateList On output rest