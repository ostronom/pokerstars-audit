{-# LANGUAGE OverloadedStrings #-}

module Server (runServer) where

import Control.Exception
import qualified Data.Text as T
import Network.Wai
import Network.Wai.Handler.Warp
import Network.HTTP.Types.URI
import Network.HTTP.Types (status200, status404, status400)
import Parser


-- runServer = run 80 app
--
-- getParam qs name = case lookup name qs of
--   Just val -> val
--   Nothing  -> let msg = T.concat ["`", name, "` GET-param required"]
--               in throw $ ParserException msg
--
--
-- mkResponse status = return . responseBuilder status headers
--   where headers = [("Content-Type", "application/json")]
--
--
-- app req respond = do
--   parsed <- fetchAndParse url password
--   -- response >>= respond
--   where
--     response = mkResponse status200
--     query = parseQueryText $ rawQueryString req
--     url = getParam query "url"
--     password = getParam query "password"
