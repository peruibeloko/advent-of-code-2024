module Day4.Part1 where

import Utils (matchOverlapping)

solution :: String -> String
solution input =
  show $ sum (map (`countMatches` inputString) countTypes)
  where
    lineSize = length . head . lines $ input
    inputString = concat $ lines input
    countTypes =
      [ countHorizontal
      , countHorizontalBackwards
      , countVertical lineSize
      , countVerticalBackwards lineSize
      , countPrimaryDiagonal lineSize
      , countSecondaryDiagonal lineSize
      , countPrimaryDiagonalBackwards lineSize
      , countSecondaryDiagonalBackwards lineSize
      ]

countMatches :: String -> String -> Int
countMatches pattern subject = length $ matchOverlapping pattern subject

countHorizontal :: String
countHorizontal = "(?=XMAS)"

countHorizontalBackwards :: String
countHorizontalBackwards = "(?=SAMX)"

countVertical :: Int -> String
countVertical lineSize =
  "(?=X.{" <> pad <> "}M.{" <> pad <> "}A.{" <> pad <> "}S)"
  where
    pad = show (lineSize - 1)

countVerticalBackwards :: Int -> String
countVerticalBackwards lineSize =
  "(?=S.{" <> pad <> "}A.{" <> pad <> "}M.{" <> pad <> "}X)"
  where
    pad = show (lineSize - 1)

countPrimaryDiagonal :: Int -> String
countPrimaryDiagonal lineSize =
  "(?=X.{" <> pad <> "}M.{" <> pad <> "}A.{" <> pad <> "}S)"
  where
    pad = show lineSize

countSecondaryDiagonal :: Int -> String
countSecondaryDiagonal lineSize =
  "(?=X.{" <> pad <> "}M.{" <> pad <> "}A.{" <> pad <> "}S)"
  where
    pad = show (lineSize - 2)

countPrimaryDiagonalBackwards :: Int -> String
countPrimaryDiagonalBackwards lineSize =
  "(?=S.{" <> pad <> "}A.{" <> pad <> "}M.{" <> pad <> "}X)"
  where
    pad = show lineSize

countSecondaryDiagonalBackwards :: Int -> String
countSecondaryDiagonalBackwards lineSize =
  "(?=S.{" <> pad <> "}A.{" <> pad <> "}M.{" <> pad <> "}X)"
  where
    pad = show (lineSize - 2)
