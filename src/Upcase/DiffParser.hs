{-# OPTIONS_GHC -fno-warn-orphans #-}

module Upcase.DiffParser
( parseDiff
, FileDelta(..)
) where

import qualified Data.Text as T
import qualified Data.Text.Lazy as LT
import qualified Text.Diff.Parse as P
import Data.Aeson
import Text.Diff.Parse.Types

data File = File T.Text [Line] deriving (Eq, Show)

instance ToJSON FileDelta where
    toJSON (FileDelta status source dest hunks) = object
        [ "status" .= show status
        , "sourceFile" .= source
        , "destinationFile" .= dest
        , "hunks" .= hunks
        ]

instance ToJSON Hunk where
    toJSON (Hunk source dest lines) = object
        [ "sourceRange" .= source
        , "destinationRange" .= dest
        , "lines" .= lines
        ]

instance ToJSON Range where
    toJSON (Range start count) = object
        [ "start" .= start
        , "count" .= count
        ]

instance ToJSON Line where
    toJSON (Line ann content) = object
        [ "annotation" .= show ann
        , "content" .= content
        ]

parseDiff :: LT.Text -> Either String FileDeltas
parseDiff = P.parseDiff . LT.toStrict
