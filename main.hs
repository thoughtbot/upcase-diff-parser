module Main where

import Network.Wai.Handler.Warp (run)
import System.Environment (getEnvironment)

import Upcase.DiffParser.App (waiApp)

main :: IO ()
main = do
    mp <- fmap (lookup "PORT") getEnvironment
    app <- waiApp

    run (maybe 3000 read mp) app
