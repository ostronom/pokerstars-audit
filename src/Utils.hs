module Utils (showEnum, lookupEnum, normalize, parseNum) where

import Debug.Trace
import Data.Default
import qualified Data.List as L
import qualified Data.Char as C
import qualified Data.Text as T


showEnum :: (Show a, Enum a) => a -> String
showEnum = (map C.toLower) . show

isParen :: Char -> Bool
isParen c = c == '(' || c == ')'

dropParens :: String -> String
dropParens = filter (not . isParen)

lookupEnum :: (Default a, Enum a) => [String] -> String -> a
lookupEnum haystack needle =
  case L.elemIndex (dropParens needle) haystack of
    Just r  -> toEnum r
    Nothing -> trace ("Not in enum:" ++ needle) def

normalize :: T.Text -> String
normalize = T.unpack . T.toLower . T.strip

-- TODO: -> throw on unreadable
parseNum :: (Read a, Num a) => String -> a
parseNum x =
  let x' = dropParens x in
  (read x') * (if length x - length x' == 2 then -1 else 1)
