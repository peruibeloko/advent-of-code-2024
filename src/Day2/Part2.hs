module Day2.Part2 where

import qualified Day2.Part1 as Part1 (direction, isReportSafeRecursion, parse)

solution :: String -> String
solution input =
  show $ length $ filter isReportSafe $ Part1.parse input

isReportSafe :: [Int] -> Bool
isReportSafe (x : xs) =
  if Part1.isReportSafeRecursion reports initialDirection
    then True
    else isReportSafeWithout reports 0
  where
    reports = (x : xs)
    initialDirection = Part1.direction x $ head xs

isReportSafeWithout :: [Int] -> Int -> Bool
isReportSafeWithout report index | index >= length report = False
isReportSafeWithout report index =
  if Part1.isReportSafeRecursion filteredReport initialDirection
    then True
    else isReportSafeWithout report $ index + 1
  where
    filteredReport = take index report ++ drop (index + 1) report
    (first : rest) = filteredReport
    initialDirection = Part1.direction first $ head rest
