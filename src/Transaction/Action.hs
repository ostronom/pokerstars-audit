module Transaction.Action(Action(..)) where

import Debug.Trace
import Data.Default


data Action = NoAction
            | TournamentRegistration
            | TournamentUnRegistration
            | StarsCoinEarned
            | TournamentWon
            deriving (Show, Eq, Enum)

instance Default Action where def = NoAction

instance Read Action where
  readsPrec _ v = [(readAction v, "")]

readAction :: String -> Action
readAction "регистрация в турнире" = TournamentRegistration
readAction "tournament registration" = TournamentRegistration

readAction "заработано starscoin (турнир)" = StarsCoinEarned
readAction "stars coin earned (tournament)" = StarsCoinEarned

readAction "победа в турнире" = TournamentWon
readAction "tournament won" = TournamentWon

readAction v = trace ("Unknown ACTION: " ++ v) def
