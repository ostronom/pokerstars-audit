{-# LANGUAGE OverloadedStrings #-}

module Parser.Base
  ( module Transaction
  , ParserException(..)
  , FileType(..)
  , ParseTarget(..)
  , mkTransaction
  ) where

import Prelude hiding (length)

import Control.Exception
import Data.Default
import Data.Sequence (length, foldlWithIndex, Seq)
import Data.Text (Text)
import Transaction
import Utils

newtype ParserException = ParserException Text deriving Show
instance Exception ParserException

data FileType = CSV | HTML

data ParseTarget = ParseTarget !FileType !Text


mkTransaction :: Seq Text -> Transaction
mkTransaction xs
  | length xs /= 16 = throw $ ParserException "Invalid data shape"
  | otherwise = foldlWithIndex toTransactionField def xs

toTransactionField :: Transaction -> Int -> Text -> Transaction
toTransactionField t i v = toTransactionField' t i (normalize v)

toTransactionField' :: Transaction -> Int -> String -> Transaction
toTransactionField' t 1 v = t { action = read v }
toTransactionField' t 4 v = t { currency = read v }
toTransactionField' t 5 v = t { amount = parseNum v }
toTransactionField' t 6 v = t { vpp = parseNum v }
toTransactionField' t 7 v = t { coins = parseNum v }
toTransactionField' t 8 v = t { tournamentMoney = parseNum v }
toTransactionField' t 10 v = t { runningBalance = parseNum v }
toTransactionField' t _ _ = t
