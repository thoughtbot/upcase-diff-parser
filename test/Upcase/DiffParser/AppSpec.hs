{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
module Upcase.DiffParser.AppSpec (main, spec) where

import Test.Hspec
import Test.Hspec.Wai
import Test.Hspec.Wai.JSON

import qualified Data.ByteString.Lazy.Char8 as BL

import Upcase.DiffParser.App

main :: IO ()
main = hspec spec

spec :: Spec
spec = with waiApp $ do
    describe "POST /" $ do
        it "returns a 200 with JSON for a valid diff" $ do
            let diff = BL.unlines
                    [ "diff --git a/example.txt b/example.txt"
                    , "new file mode 100644"
                    , "index 0000000..0a34cad"
                    , "--- /dev/null"
                    , "+++ b/example.txt"
                    , "@@ -0,0 +1 @@"
                    , "+First line"
                    ]

            post "/" diff `shouldRespondWith` [json|
                [
                  {
                    "status": "Created",
                    "content": {
                      "tag": "Hunks",
                      "contents": [
                        {
                          "lines": [
                            {
                              "annotation": "Added",
                              "content": "First line"
                            }
                          ],
                          "destRange": {
                            "startingLineNumber": 1,
                            "numberOfLines": 1
                          },
                          "sourceRange": {
                            "startingLineNumber": 0,
                            "numberOfLines": 0
                          }
                        }
                      ]
                    },
                    "destFile": "example.txt",
                    "sourceFile": "example.txt"
                  }
                ]
            |] { matchStatus = 200 }

        it "returns a 422 with JSON error for an invalid diff" $ do
            let diff = BL.unlines
                    [ "diff --git a/example.txt b/example.txt"
                    , "Totally invalid garbage!"
                    ]

            post "/" diff `shouldRespondWith` [json|
                {"error":"endOfInput"}
            |] { matchStatus = 400 }
