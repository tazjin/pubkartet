{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE TemplateHaskell            #-}

-- |Types and database instances for the pubs in Ølkartet
module Pubs where

import           Control.Applicative
import           Control.Lens
import           Data.Aeson
import           Data.Aeson.TH
import           Data.Default                         (def)
import           Data.Text                            (Text)
import           Database.PostgreSQL.Simple
import           Database.PostgreSQL.Simple.FromField
import           Database.PostgreSQL.Simple.FromRow
import           Database.PostgreSQL.Simple.Types     (fromPGArray)

-- | Latitude and longitude in normal geographic projection
data Geography = Geography { _latitude  :: Double,
                             _longitude :: Double }
                 deriving (Eq, Ord, Show)

makeLenses ''Geography
$(deriveJSON defaultOptions{fieldLabelModifier = drop 1} ''Geography)

newtype PubID = PubID { getPubID :: Integer }
                deriving (Eq, Ord, Show, FromField, FromJSON, ToJSON)

data Pub = Pub { _id          :: PubID,
                 _name        :: Text,
                 _description :: Maybe Text,
                 _tags        :: [Text],
                 _location    :: Geography }
         deriving (Eq, Ord, Show)

makeLenses ''Pub
$(deriveJSON defaultOptions{fieldLabelModifier = drop 1} ''Pub)

-- | Postgres wrappers and functions implementation

instance FromRow Pub where
  fromRow = Pub <$> field <*> field <*> field
            <*> (fmap fromPGArray field)
            <*> (Geography <$> field <*> field)

-- | Establish a connection to the default Ølkartet DB (local)
connectØlkartetDB :: IO Connection
connectØlkartetDB = connect defaultConnectInfo { connectDatabase = "olkartet" }

getAllPubs :: Connection -> IO [Pub]
getAllPubs = flip query_ "SELECT pub_key, name, description, tags, ST_X(location::geometry), ST_Y(location::geometry) FROM pubs"

getPubsByTag :: Connection -> Text -> IO [Pub]
getPubsByTag conn tag = query conn "SELECT pub_key, name, description, tags, ST_X(location::geometry), ST_Y(location::geometry) FROM pubs WHERE tags @> ARRAY[?]" $ Only tag
