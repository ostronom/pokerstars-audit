{-# LANGUAGE OverloadedStrings #-}
module Transaction
  ( Action(..)
  , Transaction(..)
  , Transactions
  , Currency(..)
  )
  where

import Data.Default
import Data.Sequence (Seq)
import Transaction.Action
import Transaction.Currency


data Transaction = Transaction { action :: !Action
                               , currency :: !Currency
                               , amount :: !Double
                               , vpp :: !Double
                               , coins :: !Double
                               , tournamentMoney :: !Double
                               , runningBalance :: !Double
                               } deriving Show

type Transactions = Seq Transaction

instance Default Transaction where
  def = Transaction { action = def
                    , currency = def
                    , amount = def
                    , vpp = def
                    , coins = def
                    , tournamentMoney = def
                    , runningBalance = def
                    }
