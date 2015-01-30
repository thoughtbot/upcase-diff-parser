# upcase-diff-parser

Simple JSON API for diff file formats. Post a diff and get back a JSON
representation.

## Usage

```
PORT=3000 cabal run
```

Then use curl to POST diffs! Wow!

## How to run tests

```
cabal configure --enable-tests && cabal build && cabal test
```
