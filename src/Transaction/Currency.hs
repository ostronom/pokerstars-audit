module Transaction.Currency where

import Data.Default
import Utils


data Currency = UnknownCurrency
              | USD
              | EUR
              deriving (Show, Eq, Enum)

instance Read Currency where
  readsPrec _ v = [(lookupEnum currencies v, "")]

currencies :: [String]
currencies = map showEnum [UnknownCurrency ..]

instance Default Currency where def = UnknownCurrency
