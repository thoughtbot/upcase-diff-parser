{-# LANGUAGE OverloadedStrings #-}

module Upcase.DiffParserSpec (main, spec) where

import qualified Data.Text.Lazy as LT
import Test.Hspec

import Upcase.DiffParser

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "parseDiff" $ do
        it "return a Diff for modified files" $ do
            let diff = LT.unlines
                    [ "diff --git a/path/to/one.txt b/path/to/one.txt"
                    , "index 802f69c..22cbdfd 100644"
                    , "--- a/path/to/one.txt"
                    , "+++ b/path/to/one.txt"
                    , "@@ -1,3 +1,5 @@"
                    , " Line one"
                    , "+In between one and two"
                    , " Line two"
                    , " Line three"
                    , "+After three"
                    , "diff --git a/path/to/two.txt b/path/to/two.txt"
                    , "index fa5ca96..7151b36 100644"
                    , "--- a/path/to/two.txt"
                    , "+++ b/path/to/two.txt"
                    , "@@ -1,3 +1,3 @@"
                    , " ABC"
                    , "-DEF"
                    , "+DEF is the second line"
                    , " GHI"
                    ]

            parseDiff diff `shouldBe` Right
                [ File "path/to/one.txt"
                    [ Line Context "Line one"
                    , Line Added   "In between one and two"
                    , Line Context "Line two"
                    , Line Context "Line three"
                    , Line Added   "After three"
                    ]
                , File "path/to/two.txt"
                    [ Line Context "ABC"
                    , Line Added   "DEF is the second line"
                    , Line Context "GHI"
                    ]
                ]
