{-# LANGUAGE OverloadedStrings #-}

module Parser.HTML (parse) where

import qualified Data.Text as T
import Data.Sequence ((|>), empty, Seq)
import Text.HTML.TagSoup
import Parser.Base

type Tags = [Tag T.Text]
type Producer = Tags -> (Tags, Tags)
type Consumer a = Tags -> a
type TagPred = Tag T.Text -> Bool

parse :: T.Text -> Transactions
parse = reducer row toTransaction . skipHead . fst . table . parseTags

toTransaction :: Tags -> Transaction
toTransaction = mkTransaction . reducer cell innerText

reducer :: Producer -> Consumer a -> Tags -> Seq a
reducer producer consumer tags = go empty tags
  where
    go xs [] = xs
    go xs ys = let (x, ys') = producer ys
               in go (xs |> consumer x) ys'

cell :: Producer
cell = between cellStart cellEnd
  where
    cellStart = isTagOpenName "TD"
    cellEnd = isTagCloseName "TD"

skipHead :: Tags -> Tags
skipHead = head . drop 2 . iterate (snd . row)

row :: Producer
row = between rowStart rowEnd
  where
    rowStart = isTagOpenName "TR"
    rowEnd = isTagCloseName "TR"

table :: Producer
table = between tableStart tableEnd
  where
    tableStart t = isTagOpenName "TABLE" t && fromAttrib "class" t == "ex"
    tableEnd t = isTagCloseName "TABLE" t

between :: TagPred -> TagPred -> Tags -> (Tags, Tags)
between start end xs = (body, drop (length body + 2) xs)
  where
    betweenF = drop 1 . takeWhile (not . end) . dropWhile (not . start)
    body = betweenF xs
