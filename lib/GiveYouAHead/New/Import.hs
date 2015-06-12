--FP

module GiveYouAHead.New.Import where
addImport :: String
          -> [String]
addImport = ("*ImportAhead":) . (:["*ImportAhead"])
