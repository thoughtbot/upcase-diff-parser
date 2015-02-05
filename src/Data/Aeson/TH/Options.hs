module Data.Aeson.TH.Options
    ( modify
    , dropPrefix
    , lowercase
    ) where

import Data.Aeson.TH (Options(..), defaultOptions)
import Data.Char (toLower)
import Data.List (stripPrefix)
import Data.Maybe (fromMaybe)

modify :: (String -> String) -> Options
modify f = defaultOptions { fieldLabelModifier = f }

dropPrefix :: String -> String -> String
dropPrefix p s = fromMaybe s $ stripPrefix p s

lowercase :: String -> String
lowercase [] = []
lowercase (x:xs) = toLower x : xs
