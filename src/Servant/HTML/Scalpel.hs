{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, OverloadedStrings #-}

module Servant.HTML.Scalpel (HTML) where

import Data.ByteString.Lazy.Char8 (unpack)
import Data.List.NonEmpty (NonEmpty((:|)))
import Data.Typeable (Typeable)
import Network.HTTP.Media ((//), (/:))
import Servant.API (Accept, MimeUnrender, contentTypes, mimeUnrender)
import Text.HTML.Scalpable (Scrapable, scraper)
import Text.HTML.Scalpel (scrapeStringLike)

data HTML deriving Typeable

instance Accept HTML where
    contentTypes _ = "text" // "html" /: ("charset", "utf-8") :| ["text" // "html"]

instance Scrapable a => MimeUnrender HTML a where
    mimeUnrender _ s = maybe (Left "scrape failed") Right $ scrapeStringLike (unpack s) scraper
