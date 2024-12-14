module Utils (toInt, imSure) where

import Text.Read (readMaybe)

toInt :: String -> Maybe Integer
toInt x = readMaybe x :: Maybe Integer

imSure :: Maybe a -> a
imSure (Just a) = a