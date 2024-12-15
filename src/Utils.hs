module Utils where

import qualified Data.Map.Strict as Map
import qualified Data.Set as Set
import Text.Read (readMaybe)

toInt :: String -> Maybe Int
toInt x = readMaybe x :: Maybe Int

imSure :: Maybe a -> a
imSure (Just a) = a

count :: (Eq a) => a -> [a] -> Int
count x xs = length . filter (== x) $ xs

frequencies :: (Ord a) => [a] -> Map.Map a Int
frequencies xs =
  foldl (\acc el -> Map.insert el (count el xs) acc) Map.empty (Set.elems $ Set.fromList xs)
