module Main (main) where

import Control.Exception (throwIO)
import ErrorHandling (PuzzleInputException (..), UnhandledPuzzleTriple, handleException, throwParseErrors)
import Runner (aoc)
import System.Directory (doesFileExist, getCurrentDirectory)
import System.Environment (getArgs)
import System.FilePath ((</>))
import Utils (toInt)

main :: IO ()
main = do
  args <- getArgs
  (day, part, inputFile) <- handleException . throwParseErrors $ parseArgs args
  puzzleInput <- handleException $ getInputData inputFile day
  putStrLn $
    "Result for day \x1B[1;33m"
      <> show day
      <> "\x1B[0m part \x1B[1;33m"
      <> show part
      <> "\x1B[0m using \x1B[1;33m"
      <> inputFile
      <> ".txt\x1B[0m was \x1B[1;33m"
      <> aoc (day, part, puzzleInput)
      <> "\x1B[0m"

parseArgs :: [String] -> Maybe UnhandledPuzzleTriple
parseArgs [dayInput, partInput, input] = Just (toInt dayInput, toInt partInput, input)
parseArgs _ = Nothing

getInputData :: String -> Int -> IO String
getInputData fileName day = do
  cwd <- getCurrentDirectory
  path <- return $ cwd </> "src" </> "Day" <> show day </> fileName <> ".txt"
  exists <- doesFileExist path
  content <- case exists of
    True -> readFile path
    False -> throwIO (InputNotFoundException day fileName)
  case content of
    "" -> throwIO (InputFileEmptyException fileName)
    _ -> return content