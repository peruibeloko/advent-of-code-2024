module Runner where

import Day1.Part1 (solution)
import Day1.Part2 (solution)

type PuzzleTriple = (Int, Int, String)

aoc :: PuzzleTriple -> String
aoc (1, 1, input) = Day1.Part1.solution input
aoc (1, 2, input) = Day1.Part2.solution input
aoc _ = "Solution not found"
