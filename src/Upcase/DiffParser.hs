module Upcase.DiffParser
( parseDiff
, Diff
, File(..)
, Line(..)
, Annotation(..)
) where

import qualified Data.Text as T
import qualified Data.Text.Lazy as LT
import qualified Text.Diff.Parse as P
import Data.Aeson
import Text.Diff.Parse.Types

type Diff = [File]

data File = File T.Text [Line] deriving (Eq, Show)

instance ToJSON File where
    toJSON (File name lines) = object
        [ "name" .= name
        , "lines" .= map lineToJSON lines
        ]

      where
        lineToJSON :: Line -> Value
        lineToJSON (Line annotation content) = object
            [ "annotation" .= (show annotation)
            , "content" .= content
            ]


parseDiff :: LT.Text -> Either String Diff
parseDiff = fmap (map toFile) . P.parseDiff . LT.toStrict

toFile :: FileDelta -> File
toFile (FileDelta _ _ name hunks) =
    File name $ filter notRemovedLine $ concatMap hunkLines hunks

  where
    notRemovedLine :: Line -> Bool
    notRemovedLine = (/= Removed) . lineAnnotation
