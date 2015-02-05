{-# OPTIONS_GHC -fno-warn-orphans #-}
module Text.Diff.Parse.Instances
    ( module Text.Diff.Parse.Types
    ) where

import Data.Aeson.TH
import Data.Aeson.TH.Options
import Text.Diff.Parse.Types

$(deriveToJSON (modify $ lowercase . dropPrefix "annotation") ''Annotation)
$(deriveToJSON (modify $ lowercase . dropPrefix "fileDelta") ''FileDelta)
$(deriveToJSON (modify $ lowercase . dropPrefix "fileStatus") ''FileStatus)
$(deriveToJSON (modify $ lowercase . dropPrefix "hunk") ''Hunk)
$(deriveToJSON (modify $ lowercase . dropPrefix "line") ''Line)
$(deriveToJSON (modify $ lowercase . dropPrefix "range") ''Range)
