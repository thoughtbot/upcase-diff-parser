module Upcase.DiffParser.App
    ( waiApp
    , parseDiff
    ) where

import Yesod.Core
import Data.Text.Lazy.Encoding (decodeUtf8)
import Data.Conduit
import Data.Conduit.Binary

import Upcase.DiffParser (parseDiff)

data App = App

instance Yesod App

mkYesod "App" [parseRoutes| / R POST |]

postR :: Handler Value
postR = do
    body <- rawRequestBody $$ sinkLbs
    let diff = parseDiff $ decodeUtf8 body
    return $ case diff of
        Left e -> object [ "error" .= e ]
        Right v -> toJSON v

waiApp :: IO Application
waiApp = toWaiApp App
