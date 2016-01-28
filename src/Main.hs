{-# LANGUAGE OverloadedStrings #-}

module Main where

-- import Server
import Parser
import Report

main :: IO ()
main =
  fetchAndParse "" "p1501" >>= print . toReport
-- main = runServer
