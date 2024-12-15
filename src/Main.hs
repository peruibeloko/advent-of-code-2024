module Main (main) where

import Debug.Trace (trace, traceM, traceShow, traceShowM)
import Runner (aoc)
import System.Directory (getCurrentDirectory)
import System.Environment (getArgs)
import System.FilePath ((</>))
import Text.Read (readMaybe)
import Utils (toInt)

main :: IO ()
main = do
  (day, part, input) <- getArgs >>= parseArgs
  contents <- getInputData input day
  result <- return $ aoc (day, part, contents)
  print result

parseArgs :: [String] -> IO (Int, Int, String)
parseArgs args =
  case args of
    [day, part, input] ->
      return (intDay, intPart, input)
      where
        intDay = errorIfNothing (toInt day) "[day] is not a number"
        intPart = errorIfNothing (toInt part) "[part] is not a number"
    _ -> error "syntax: aoc [day] [part] [puzzle input]"

getInputData :: String -> Int -> IO String
getInputData fileName day = do
  cwd <- getCurrentDirectory
  path <- return (cwd </> "src" </> "Day" ++ show day </> fileName ++ ".txt")
  readFile path

errorIfNothing :: Maybe a -> String -> a
errorIfNothing a msg =
  case a of
    Just a -> a
    Nothing -> error msg