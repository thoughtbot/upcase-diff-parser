{-# OPTIONS_GHC -fno-warn-orphans #-}
module Text.Diff.Parse.Instances
    ( module Text.Diff.Parse.Types
    ) where

import Data.Aeson.TH
import Data.Aeson.TH.Util
import Text.Diff.Parse.Types

$(deriveToJSON (modify $ lowercase . drop 10) ''Annotation)
$(deriveToJSON (modify $ lowercase . drop 9 ) ''FileDelta)
$(deriveToJSON (modify $ lowercase . drop 10) ''FileStatus)
$(deriveToJSON (modify $ lowercase . drop 4 ) ''Hunk)
$(deriveToJSON (modify $ lowercase . drop 4 ) ''Line)
$(deriveToJSON (modify $ lowercase . drop 5 ) ''Range)
