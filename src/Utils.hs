module Utils where

import Data.Map (Map)
import qualified Data.Map as Map
import qualified Data.Set as Set
import Text.Read (readMaybe)
import Text.Regex.TDFA ((=~))

toInt :: String -> Maybe Int
toInt x = readMaybe x :: Maybe Int

-- | Unsafely unwraps `Maybe` values, for when you're *really sure*
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

-- | Returns `Nothing` for empty strings and `Just` for everything else
maybeString :: String -> Maybe String
maybeString "" = Nothing
maybeString str = Just str

-- | Given a list of `Show`able values, concatenates all of them into a single string
--
-- Useful for debugging
interpolate :: (Show a) => [a] -> String
interpolate xs = foldl (<>) "" $ map show xs

-- | `String`
type Pattern = String

-- | Returns a list, of lists, of matches of `pattern` agains `subject`
matchRaw :: Pattern -> String -> [[String]]
matchRaw pattern subject = subject =~ pattern :: [[String]]

-- | Returns the first match of `subject` against `pattern`
firstMatch :: Pattern -> String -> String
firstMatch pattern subject = subject =~ pattern :: String

-- | Returns all matches of `pattern` agains `subject`
matchAll :: Pattern -> String -> [String]
matchAll pattern subject = map head $ matchRaw pattern subject

-- | Returns a list of the captured groups in the matches of `pattern` agains `subject`
matchGroups :: Pattern -> String -> [[String]]
matchGroups pattern subject = map tail $ matchRaw pattern subject

-- | Tests whether `subject` matches against `pattern`
isMatch :: Pattern -> String -> Bool
isMatch pattern subject = subject =~ pattern :: Bool
