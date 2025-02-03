{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE RankNTypes #-}

module RegexExamples where

import Data.Array (Array)
import Text.Regex.PCRE (
  AllMatches (getAllMatches),
  AllSubmatches (getAllSubmatches),
  AllTextMatches (getAllTextMatches),
  AllTextSubmatches (getAllTextSubmatches),
  MatchArray,
  MatchLength,
  MatchOffset,
  MatchResult (mrSubs),
  MatchText,
  Regex,
  RegexContext,
  (=~),
 )

base ::
  forall target. (RegexContext Regex String target) => String -> String -> target
base pattern subject = pattern =~ subject

getAllTextSubmatchesBase ::
  (RegexContext Regex String (AllTextSubmatches f b)) => String -> String -> f b
getAllTextSubmatchesBase pattern subject = getAllTextSubmatches $ base pattern subject

getAllTextMatchesBase ::
  (RegexContext Regex String (AllTextMatches f b)) => String -> String -> f b
getAllTextMatchesBase pattern subject = getAllTextMatches $ base pattern subject

getAllMatchesBase ::
  (RegexContext Regex String (AllMatches f b)) => String -> String -> f b
getAllMatchesBase pattern subject = getAllMatches $ base pattern subject

-- bool: first match, returns True or False
-- Context: RegexContext a b Bool
test :: String -> String -> Bool
test = base

-- count: all matches, returns count
-- Context: RegexContext a b Int
countMatches :: String -> String -> Int
countMatches = base

--
-- First match only using MatchArray and MatchResult.
--

-- first match, all captures, returns offset and length
-- Context: RegexContext a b MatchArray
firstMatchCapturesOffsets :: String -> String -> MatchArray
firstMatchCapturesOffsets = base

-- first match, all captures, returns text, includes before and after text
-- Context: RegexContext a b (MatchResult b)
exampleMatchResult :: String -> String -> MatchResult String
exampleMatchResult = base

-- putStrLn $ "before text         : " ++ (mrBefore matches)
-- putStrLn $ "after text          : " ++ (mrAfter matches)
-- putStrLn $ "match text          : " ++ (mrMatch matches)
-- putStrLn $ "captures 1-n (list) : " ++ show (mrSubList matches)
-- putStrLn $ "all captures (array): " ++ show (mrSubs matches)

--
-- First match only using tuples.
--

-- first match, 0-th capture, returns offset and length
-- Context: RegexContext a b (MatchOffset, MatchLength)
exampleOffsetLength :: String -> String -> (MatchOffset, MatchLength)
exampleOffsetLength = base

-- first match, 0-th capture, returns text including before and after text
-- Context: RegexContext a b (b, b, b)
exampleBeforeMatchAfter :: String -> String -> (String, String, String)
exampleBeforeMatchAfter = base

-- first match, all captures, returns text, offset and length including before and after text
-- Context: RegexContext a b (b, MatchText b, b)
exampleBeforeMatchTextAfter ::
  String -> String -> (String, MatchText String, String)
exampleBeforeMatchTextAfter = base

-- first match, all captures, returns text
-- Context: RegexContext a b (b, b, b, [b])
exampleBeforeMatchAfterWithCaptures ::
  String -> String -> (String, String, String, [String])
exampleBeforeMatchAfterWithCaptures = base

--
-- All matches returning a list.
--

-- all matches, all captures, returns text
-- Context: RegexContext a b [[b]]
exampleListOfLists :: String -> String -> [[String]]
exampleListOfLists = base

-- all matches, all captures, returns text, offset and length
-- Context: RegexContext a b [MatchText b]
exampleListOfMatchesText :: String -> String -> [MatchText String]
exampleListOfMatchesText = base

-- all matches, all captures, returns offset and length
-- Context: RegexContext a b [MatchArray]
exampleListOfMatchesArray :: String -> String -> [MatchArray]
exampleListOfMatchesArray = base

--
-- First match only using getAllTextSubmatches.
--

-- first match, all captures, returns text
-- Context: RegexContext a b (AllTextSubmatches (Array Int) b)
exampleAllTextSubmatchesArrayText :: String -> String -> Array Int String
exampleAllTextSubmatchesArrayText = getAllTextSubmatchesBase

-- first match, all captures, returns text
-- Context: RegexContext a b (AllTextSubmatches [] b)
exampleAllTextSubmatchesListText :: String -> String -> [String]
exampleAllTextSubmatchesListText = getAllTextSubmatchesBase

-- first match, all captures, returns text, offset and length
-- Context: RegexContext a b (AllTextSubmatches [] (b, (MatchOffset, MatchLength)))
exampleAllTextSubmatchesListTextOffsetLength ::
  String -> String -> [(String, (MatchOffset, MatchLength))]
exampleAllTextSubmatchesListTextOffsetLength = getAllTextSubmatchesBase

-- first match, all captures, returns text, offset and length
-- Context: RegexContext a b (AllTextSubmatches (Array Int) (b, (MatchOffset, MatchLength)))
exampleAllTextSubmatchesArrayTextOffsetLength ::
  String -> String -> Array Int (String, (MatchOffset, MatchLength))
exampleAllTextSubmatchesArrayTextOffsetLength = getAllTextSubmatchesBase

-- first match, all captures, returns offset and length
-- Context: RegexContext a b (AllSubmatches [] (MatchOffset, MatchLength))
exampleAllSubmatchesListOffsetLength ::
  String -> String -> [(MatchOffset, MatchLength)]
exampleAllSubmatchesListOffsetLength pattern subject = getAllSubmatches $ base pattern subject

--
-- All matches using getAllTextMatches
--

-- all matches, all captures, returns text
-- Context: RegexContext a b (AllTextMatches (Array Int) (Array Int b))
exampleAllTextMatchesArrayArray ::
  String -> String -> Array Int (Array Int String)
exampleAllTextMatchesArrayArray = getAllTextMatchesBase

-- all matches, all captures, returns text
-- Context: RegexContext a b (AllTextMatches [] (Array Int b))
exampleAllTextMatchesListArray :: String -> String -> [Array Int String]
exampleAllTextMatchesListArray = getAllTextMatchesBase

-- all matches, all captures, returns text
-- Context: RegexContext a b (AllTextMatches (Array Int) [b])
exampleAllTextMatchesArrayList :: String -> String -> Array Int [String]
exampleAllTextMatchesArrayList = getAllTextMatchesBase

-- all matches, 0-th capture, returns text
-- Context: RegexContext a b (AllTextMatches (Array Int) b)
exampleAllTextMatchesArrayText :: String -> String -> Array Int String
exampleAllTextMatchesArrayText = getAllTextMatchesBase

-- all matches, 0-th capture, return text
-- Context: RegexContext a b (AllTextMatches [] b)
exampleAllTextMatchesListText :: String -> String -> [String]
exampleAllTextMatchesListText = getAllTextMatchesBase

-- all matches, all captures, returns text, offset and length
-- Context: RegexContext a b (AllTextMatches (Array Int) (MatchText b))
exampleAllTextMatchesArrayMatchText ::
  String -> String -> Array Int (MatchText String)
exampleAllTextMatchesArrayMatchText = getAllTextMatchesBase

--
-- All matches using getAllMatches
--

-- all matches, all captures, returns offset and length
-- Context: RegexContext a b (AllMatches (Array Int) MatchArray)
exampleAllMatchesArrayMatchArray :: String -> String -> Array Int MatchArray
exampleAllMatchesArrayMatchArray = getAllMatchesBase

-- all matches, 0-th capture, returns offset and length
-- Context: RegexContext a b (AllMatches (Array Int) (MatchOffset, MatchLength))
exampleAllMatchesArrayOffsetLength ::
  String -> String -> Array Int (MatchOffset, MatchLength)
exampleAllMatchesArrayOffsetLength = getAllMatchesBase

-- all matches, 0-th capture, returns offset and length
-- Context: RegexContext a b (AllMatches [] (MatchOffset, MatchLength))
exampleAllMAtchesListOffsetLength ::
  String -> String -> [(MatchOffset, MatchLength)]
exampleAllMAtchesListOffsetLength = getAllMatchesBase
