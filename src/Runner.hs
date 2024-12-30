module Runner where

import Day1.Part1 (solution)
import Day1.Part2 (solution)
import Day10.Part1 (solution)
import Day10.Part2 (solution)
import Day11.Part1 (solution)
import Day11.Part2 (solution)
import Day12.Part1 (solution)
import Day12.Part2 (solution)
import Day13.Part1 (solution)
import Day13.Part2 (solution)
import Day14.Part1 (solution)
import Day14.Part2 (solution)
import Day15.Part1 (solution)
import Day15.Part2 (solution)
import Day16.Part1 (solution)
import Day16.Part2 (solution)
import Day17.Part1 (solution)
import Day17.Part2 (solution)
import Day18.Part1 (solution)
import Day18.Part2 (solution)
import Day19.Part1 (solution)
import Day19.Part2 (solution)
import Day2.Part1 (solution)
import Day2.Part2 (solution)
import Day20.Part1 (solution)
import Day20.Part2 (solution)
import Day21.Part1 (solution)
import Day21.Part2 (solution)
import Day22.Part1 (solution)
import Day22.Part2 (solution)
import Day23.Part1 (solution)
import Day23.Part2 (solution)
import Day24.Part1 (solution)
import Day24.Part2 (solution)
import Day25.Part1 (solution)
import Day25.Part2 (solution)
import Day3.Part1 (solution)
import Day3.Part2 (solution)
import Day4.Part1 (solution)
import Day4.Part2 (solution)
import Day5.Part1 (solution)
import Day5.Part2 (solution)
import Day6.Part1 (solution)
import Day6.Part2 (solution)
import Day7.Part1 (solution)
import Day7.Part2 (solution)
import Day8.Part1 (solution)
import Day8.Part2 (solution)
import Day9.Part1 (solution)
import Day9.Part2 (solution)

type PuzzleTriple = (Int, Int, String)

aoc :: PuzzleTriple -> String
aoc (1, 1, input) = Day1.Part1.solution input
aoc (1, 2, input) = Day1.Part2.solution input
aoc (2, 1, input) = Day2.Part1.solution input
aoc (2, 2, input) = Day2.Part2.solution input
aoc (3, 1, input) = Day3.Part1.solution input
aoc (3, 2, input) = Day3.Part2.solution input
aoc (4, 1, input) = Day4.Part1.solution input
aoc (4, 2, input) = Day4.Part2.solution input
aoc (5, 1, input) = Day5.Part1.solution input
aoc (5, 2, input) = Day5.Part2.solution input
aoc (6, 1, input) = Day6.Part1.solution input
aoc (6, 2, input) = Day6.Part2.solution input
aoc (7, 1, input) = Day7.Part1.solution input
aoc (7, 2, input) = Day7.Part2.solution input
aoc (8, 1, input) = Day8.Part1.solution input
aoc (8, 2, input) = Day8.Part2.solution input
aoc (9, 1, input) = Day9.Part1.solution input
aoc (9, 2, input) = Day9.Part2.solution input
aoc (10, 1, input) = Day10.Part1.solution input
aoc (10, 2, input) = Day10.Part2.solution input
aoc (11, 1, input) = Day11.Part1.solution input
aoc (11, 2, input) = Day11.Part2.solution input
aoc (12, 1, input) = Day12.Part1.solution input
aoc (12, 2, input) = Day12.Part2.solution input
aoc (13, 1, input) = Day13.Part1.solution input
aoc (13, 2, input) = Day13.Part2.solution input
aoc (14, 1, input) = Day14.Part1.solution input
aoc (14, 2, input) = Day14.Part2.solution input
aoc (15, 1, input) = Day15.Part1.solution input
aoc (15, 2, input) = Day15.Part2.solution input
aoc (16, 1, input) = Day16.Part1.solution input
aoc (16, 2, input) = Day16.Part2.solution input
aoc (17, 1, input) = Day17.Part1.solution input
aoc (17, 2, input) = Day17.Part2.solution input
aoc (18, 1, input) = Day18.Part1.solution input
aoc (18, 2, input) = Day18.Part2.solution input
aoc (19, 1, input) = Day19.Part1.solution input
aoc (19, 2, input) = Day19.Part2.solution input
aoc (20, 1, input) = Day20.Part1.solution input
aoc (20, 2, input) = Day20.Part2.solution input
aoc (21, 1, input) = Day21.Part1.solution input
aoc (21, 2, input) = Day21.Part2.solution input
aoc (22, 1, input) = Day22.Part1.solution input
aoc (22, 2, input) = Day22.Part2.solution input
aoc (23, 1, input) = Day23.Part1.solution input
aoc (23, 2, input) = Day23.Part2.solution input
aoc (24, 1, input) = Day24.Part1.solution input
aoc (24, 2, input) = Day24.Part2.solution input
aoc (25, 1, input) = Day25.Part1.solution input
aoc (25, 2, input) = Day25.Part2.solution input
aoc _ = "Solution not found"
