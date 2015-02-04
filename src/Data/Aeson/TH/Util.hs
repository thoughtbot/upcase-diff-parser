module Data.Aeson.TH.Util
    ( modify
    , lowercase
    ) where

import Data.Char
import Data.Aeson.TH

modify :: (String -> String) -> Options
modify f = defaultOptions
    { fieldLabelModifier = f
    }

lowercase :: String -> String
lowercase [] = []
lowercase (x:xs) = toLower x : xs
