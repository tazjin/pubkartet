{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

module Main where

import           API
import           Control.Exception          (bracket)
import           Control.Monad.IO.Class     (liftIO)
import           Data.Text                  (Text, pack)
import           Database.PostgreSQL.Simple (Connection, close)
import           Network.Wai                (Application)
import           Network.Wai.Handler.Warp   (run)
import           Pubs
import           Servant
import           Servant.JQuery             (jsForAPI)
import           Servant.Server

pubsHandler :: Connection -> Server PubAPI
pubsHandler conn =
       (liftIO $ getAllPubs conn)
  :<|> (liftIO . getPubsByTag conn)

-- * Static file handling

type StaticRoutes = "static" :> "pubs.js" :> Get '[PlainText] Text
               :<|> "static" :> Raw

staticHandler :: Server StaticRoutes
staticHandler =  (return $ pack getJSClient)
            :<|> serveDirectory "/home/vincent/source/olkartet/static"

-- | Generate foreign code for Mapbox demo
getJSClient :: String
getJSClient = jsForAPI pubAPI

-- -- * Server setup

-- | The server type combines the pub API with the serving of static
--   assets for the web demo.
--   These are not part of the pub API of course, so here they are a
--   separate "API" that we combine with the real one.
serverType :: Proxy (PubAPI :<|> StaticRoutes)
serverType = Proxy

ølkartetServer :: Connection -> Application
ølkartetServer c = serve serverType
                   (pubsHandler c :<|> staticHandler)

main :: IO ()
main = bracket connectØlkartetDB close
       (run 8080 . ølkartetServer)
