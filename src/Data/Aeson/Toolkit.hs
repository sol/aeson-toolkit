{-# LANGUAGE FlexibleContexts, FlexibleInstances, MultiParamTypeClasses #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
module Data.Aeson.Toolkit where

import           Data.Text (Text)
import qualified Data.ByteString.Lazy as L
import           Control.Failure
import           Data.Aeson as Aeson
import           Data.Aeson.Types

instance Failure String Parser where
  failure = fail

instance Failure String Result where
  failure = Error

decode :: (FromJSON a, Failure String m) => L.ByteString -> m a
decode = either failure return . eitherDecode

decode' :: (FromJSON a, Failure String m) => L.ByteString -> m a
decode' = either failure return . eitherDecode'

(.:) :: (Failure String m, FromJSON a) => Object -> Text -> m a
o .: k = (either failure return . parseEither (Aeson..: k)) o
