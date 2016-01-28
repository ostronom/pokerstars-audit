{-# LANGUAGE OverloadedStrings #-}

module Parser (module Parser.Base, fetchAndParse) where

import Parser.Base
import qualified Data.Text as T
import Control.Exception
import System.Process (shell)
import System.Process.Text (readCreateProcessWithExitCode)
import System.Exit (ExitCode(..))
import qualified Parser.HTML as H
import qualified Parser.CSV as C


getFileType :: T.Text -> FileType
getFileType content
  | (T.toLower $ T.take 5 content) == "<html" = HTML
  | otherwise = CSV


getTarget :: T.Text -> T.Text -> IO ParseTarget
getTarget url password = do
  let args = T.unpack $ T.intercalate " " ["getpstats.sh", url, password]
  (code, stdout, stderr) <- readCreateProcessWithExitCode (shell args) ""
  case code of
    ExitFailure _ -> throwIO $ ParserException stderr
    _             -> return $ ParseTarget (getFileType stdout) stdout


parse :: ParseTarget -> Transactions
parse (ParseTarget HTML t) = H.parse t
parse (ParseTarget CSV t) = C.parse t

fetchAndParse :: T.Text -> T.Text -> IO Transactions
fetchAndParse url password = getTarget url password >>= return . parse
