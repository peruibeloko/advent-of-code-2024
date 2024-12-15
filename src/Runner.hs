module Runner where

import Day1.Part1 (solution)
import Day1.Part2 (solution)

aoc :: (Int, Int, String) -> String
aoc (day, part, input) =
  case (day, part) of
    (1, 1) -> Day1.Part1.solution input
    (1, 2) -> Day1.Part2.solution input
    _ -> "Solution not found"
