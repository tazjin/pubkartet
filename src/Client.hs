{-# LANGUAGE DataKinds         #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeOperators     #-}

-- | Servant based client for the pub API
module Client (runEitherT, getPubs, getTaggedPubs) where

import           API
import           Control.Monad.Trans.Either
import           Data.Text
import           Pubs
import           Servant
import           Servant.Client

getPubs :: EitherT ServantError IO [Pub]
getTaggedPubs :: Text -> EitherT ServantError IO [Pub]

(getPubs :<|> getTaggedPubs) = client pubAPI host
  where host = BaseUrl Http "localhost" 8080
