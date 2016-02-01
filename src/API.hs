{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeOperators         #-}

-- | Servant API for retrieving pubs
module API where

import           Data.Proxy
import           Data.Text
import           Pubs
import           Servant
import           Servant.API
import           Servant.Docs

type PubAPI = "pubs" :> Get '[JSON] [Pub]
         :<|> "pubs" :> "tagged"
                     :> Capture "tag" Text
                     :> Get '[JSON] [Pub]

pubAPI :: Proxy PubAPI
pubAPI = Proxy

-- Documentation instances
instance ToCapture (Capture "tag" Text) where
  toCapture _ = DocCapture "tag" "A tag to filter pubs by"

instance ToSample [Pub] [Pub] where
  toSample _ = Just [samplePub]

samplePub :: Pub
samplePub = Pub (PubID 53) "BD57 (BrewDog)"
            (Just "https://untappd.com/venue/2875445")
            ["godt-utvalg"] (Geography 10.7572369 59.9199413)
