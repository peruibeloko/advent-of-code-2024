module Day4.Part2 where

import Utils (matchOverlapping)

solution :: String -> String
solution input =
  show $ sum (map (`countMatches` inputString) countTypes)
  where
    lineSize = length . head . lines $ input
    inputString = concat $ lines input
    countTypes =
      [ countPrimSec lineSize,
        countPrimRevSec lineSize,
        countPrimSecRev lineSize,
        countPrimRevSecRev lineSize
      ]

countMatches :: String -> String -> Int
countMatches pattern subject = length $ matchOverlapping pattern subject

countPrimSec :: Int -> String
countPrimSec lineSize =
  "(?=M.M.{" <> pad <> "}A.{" <> pad <> "}S.S)"
  where
    pad = show $ lineSize - 2

countPrimRevSec :: Int -> String
countPrimRevSec lineSize =
  "(?=S.M.{" <> pad <> "}A.{" <> pad <> "}S.M)"
  where
    pad = show $ lineSize - 2

countPrimSecRev :: Int -> String
countPrimSecRev lineSize =
  "(?=M.S.{" <> pad <> "}A.{" <> pad <> "}M.S)"
  where
    pad = show $ lineSize - 2

countPrimRevSecRev :: Int -> String
countPrimRevSecRev lineSize =
  "(?=S.S.{" <> pad <> "}A.{" <> pad <> "}M.M)"
  where
    pad = show $ lineSize - 2
