module Utils where

import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.Set as Set
import Text.Read (readMaybe)

toInt :: String -> Maybe Int
toInt x = readMaybe x :: Maybe Int

imSure :: Maybe a -> a
imSure (Just a) = a

-- | Counts how many times `x` appears in `xs`
count :: (Eq a) => a -> [a] -> Int
count x xs = length . filter (== x) $ xs

-- | Returns a mapping between each distinct item in `xs` and a count of its occourences.
--
-- Essentially a dictionary of `for x in xs -> count x`
frequencies :: (Ord a) => [a] -> Map a Int
frequencies xs =
  foldl (\acc el -> Map.insert el (count el xs) acc) Map.empty (Set.elems $ Set.fromList xs)

maybeString :: String -> Maybe String
maybeString "" = Nothing
maybeString str = Just str

interpolate :: (Show a) => [a] -> String
interpolate xs = foldl (<>) "" $ map show xs