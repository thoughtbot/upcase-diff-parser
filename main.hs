module Main where

import Network.Wai.Handler.Warp (run)
import System.Environment

import Upcase.DiffParser.App (waiApp)

main = getEnv "PORT" >>= \p -> waiApp >>= run (read p)
