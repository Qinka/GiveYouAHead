




module GiveYouAHead.New
    (
    new
    ) where

      import System.Time               (getClockTime)
      import GiveYouAHead.Common       (writeF)
      import Macro.MacroParser(MacroNode(..))
      import Macro.MacroIO(getMacroFromFile)
      import Macro.MacroReplace(findMacro,splitMacroDef,toText)

      new :: String         -- Template
          -> String         -- id or num
          -> [String]       -- import list
          -> IO ()

      new tp num imp= do
        mnode <- getMacroFromFile $ "new." ++ if null tp then "default" else tp
        lsnode <- getMacroFromFile "new"
        let (dls,_) = splitMacroDef lsnode
        time <- getClockTime
        let (as,bs) = splitMacroDef mnode
        writeF (findMacro dls "numLeft"++num++findMacro dls"numRight") $ concatMap show $ toText (MacroDef "timenow" (show time):List "importList" (if null imp then [""] else imp):as,bs)
        return ()
