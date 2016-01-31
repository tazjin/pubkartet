{-# LANGUAGE DataKinds     #-}
{-# LANGUAGE TypeOperators #-}

-- | Servant API for retrieving pubs
module API where

import           Data.Proxy
import           Data.Text
import           Pubs
import           Servant

type PubAPI = "pubs" :> Get '[JSON] [Pub]
         :<|> "pubs" :> "tagged"
                     :> Capture "tag" Text
                     :> Get '[JSON] [Pub]

pubAPI :: Proxy PubAPI
pubAPI = Proxy
