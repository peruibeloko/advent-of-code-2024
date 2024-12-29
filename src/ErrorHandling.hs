module ErrorHandling where

import Control.Exception (Exception, catch, throwIO)
import Runner (PuzzleTriple)
import System.Exit (die)

type UnhandledPuzzleTriple = (Maybe Int, Maybe Int, String)

data PuzzleInputException
  = ArgNotNumberException String
  | InputNotFoundException Int String
  | InputFileEmptyException String
  | WrongArgsException

instance Exception PuzzleInputException

instance Show PuzzleInputException where
  show WrongArgsException = "syntax: aoc2024 [day] [part] [input]"
  show (ArgNotNumberException arg) = "bad argument: [" <> arg <> "] is not a number"
  show (InputNotFoundException day input) = "file not found: src/Day" <> show day <> "/" <> input <> ".txt is missing"
  show (InputFileEmptyException file) = "missing data: " <> file <> ".txt is empty"

handleException :: IO a -> IO a
handleException failable = catch failable (\e -> die . show $ (e :: PuzzleInputException))

throwParseErrors :: Maybe UnhandledPuzzleTriple -> IO PuzzleTriple
throwParseErrors Nothing = throwIO WrongArgsException
throwParseErrors (Just (maybeDay, maybePart, inputFile)) = do
  day <- case maybeDay of
    Just day -> return day
    Nothing -> throwIO (ArgNotNumberException "day")
  part <- case maybePart of
    Just part -> return part
    Nothing -> throwIO (ArgNotNumberException "part")
  return (day, part, inputFile)