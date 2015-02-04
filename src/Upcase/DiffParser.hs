module Upcase.DiffParser
    ( parseDiff
    , module Text.Diff.Parse.Types
    ) where

import Text.Diff.Parse.Types
import Text.Diff.Parse.Instances ()

import qualified Data.Text.Lazy as LT
import qualified Text.Diff.Parse as P

parseDiff :: LT.Text -> Either String FileDeltas
parseDiff = P.parseDiff . LT.toStrict
