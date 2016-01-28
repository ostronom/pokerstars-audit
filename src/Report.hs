module Report (toReport) where

import Transaction


data Report = Report { total :: !Double } deriving Show

toReport :: Transactions -> Report
toReport = undefined
-- toReport ts = fold .. ts
