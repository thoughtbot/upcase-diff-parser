module Upcase.DiffParser.App
    ( waiApp
    , parseDiff
    ) where

import Yesod.Core
import Data.Text.Lazy.Encoding (decodeUtf8)
import Data.Conduit
import Data.Conduit.Binary
import Network.HTTP.Types.Status (badRequest400)

import Upcase.DiffParser (parseDiff)

data App = App

instance Yesod App

mkYesod "App" [parseRoutes| / R POST |]

postR :: Handler Value
postR = do
    body <- rawRequestBody $$ sinkLbs
    either respondError (return . toJSON) $ parseDiff $ decodeUtf8 body

respondError :: MonadHandler m => String -> m Value
respondError e = sendResponseStatus badRequest400 $ object [ "error" .= e ]

waiApp :: IO Application
waiApp = toWaiApp App
