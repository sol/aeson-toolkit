{-# LANGUAGE FlexibleContexts #-}
module Data.Aeson.Toolkit where

import           Data.Text (Text)
import qualified Data.ByteString.Lazy as L
import           Control.Failure
import           Data.Aeson as Aeson
import           Data.Aeson.Types

decode :: (FromJSON a, Failure String m) => L.ByteString -> m a
decode = either failure return . eitherDecode

decode' :: (FromJSON a, Failure String m) => L.ByteString -> m a
decode' = either failure return . eitherDecode'

(.:) :: (Failure String m, FromJSON a) => Object -> Text -> m a
o .: k = (either failure return . parseEither (Aeson..: k)) o
