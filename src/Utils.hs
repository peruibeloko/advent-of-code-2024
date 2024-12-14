module Utils (toInt) where

import Text.Read (readMaybe)

toInt :: String -> Maybe Integer
toInt x = readMaybe x :: Maybe Integer