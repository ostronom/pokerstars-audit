{-# LANGUAGE OverloadedStrings #-}

module Parser.CSV (parse) where

import Control.Exception
import qualified Data.Csv as C
import qualified Data.ByteString.Lazy as LBS
import qualified Data.Text as T
import qualified Data.Text.Encoding as TE
import qualified Data.Sequence as S
import qualified Data.Vector as V
import Parser.Base


parse :: T.Text -> Transactions
parse t = case csvToSeq <$> parseCSV t of
    Left err -> throw $ ParserException (T.pack err)
    Right xs -> S.fromList $ map mkTransaction xs

csvToSeq :: V.Vector [T.Text] -> [S.Seq T.Text]
csvToSeq = map S.fromList . drop 2 . V.toList

parseCSV :: T.Text -> Either String (V.Vector [T.Text])
parseCSV = C.decode C.NoHeader . LBS.fromStrict . TE.encodeUtf8
