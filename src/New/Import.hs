--FP
module New.Import where

addImport   ::  String      --file
            ->  [String]    


addImport  = ("*ImportAhead":) . (:["*ImportBack"])


