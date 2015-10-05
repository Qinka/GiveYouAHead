




module GiveYouAHead.New.Import
    (
    addImport
    ) where

      addImport :: String -> [String]
      addImport =  ("*ImportAhead":) . (:["*ImportBack"])
