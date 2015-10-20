




module GiveYouAHead.Clean
    (
    clean
    ) where

      import System.Process(createProcess,shell,waitForProcess)
      import Macro.MacroIO(getMacroFromFile)
      import Macro.MacroReplace(splitMacroDef,toText)


      clean :: IO()

      clean = do
        t <- getMacroFromFile "clean"
        (_,_,_,hp) <- createProcess $ shell $ concatMap show $ toText $ splitMacroDef t
        _ <- waitForProcess hp
        putStrLn "Cleaned!"
