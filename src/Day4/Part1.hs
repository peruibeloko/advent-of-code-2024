module Day4.Part1 where

solution :: String -> String
solution input =
  show $ foldl (+) 0 (mapFns countTypes inputString) -- ! missing actual matching stuff
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
  concat
    [ "(?=S.{"
    , show (lineSize - 1)
    , "}A.{"
    , show (lineSize - 1)
    , "}M.{"
    , show (lineSize - 1)
    , "}X)"
    ]

countPrimaryDiagonal :: Int -> String
countPrimaryDiagonal lineSize =
  concat
    [ "(?=X.{"
    , show (lineSize)
    , "}M.{"
    , show (lineSize)
    , "}A.{"
    , show (lineSize)
    , "}S)"
    ]

countSecondaryDiagonal :: Int -> String
countSecondaryDiagonal lineSize =
  concat
    [ "(?=X.{"
    , show (lineSize - 2)
    , "}M.{"
    , show (lineSize - 2)
    , "}A.{"
    , show (lineSize - 2)
    , "}S)"
    ]

countPrimaryDiagonalBackwards :: Int -> String
countPrimaryDiagonalBackwards lineSize =
  concat
    [ "(?=S.{"
    , show (lineSize)
    , "}A.{"
    , show (lineSize)
    , "}M.{"
    , show (lineSize)
    , "}X)"
    ]

countSecondaryDiagonalBackwards :: Int -> String
countSecondaryDiagonalBackwards lineSize =
  concat
    [ "(?=S.{"
    , show (lineSize - 2)
    , "}A.{"
    , show (lineSize - 2)
    , "}M.{"
    , show (lineSize - 2)
    , "}X)"
    ]
