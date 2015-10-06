




module GiveYouAHead.Clean
    (
    clean
    ) where

      import System.Process(createProcess,shell,waitForProcess)
      import Data.GiveYouAHead(toText)
      import GiveYouAHead.Common()
      import GiveYouAHead.Template(getTemplate,getCM)


      clean :: IO()

      clean = do
        cm <- getCM
        t <- getTemplate "clean"
        (_,_,_,hp) <- createProcess $ shell $ concat $ toText cm t
        _ <- waitForProcess hp
        putStrLn "Cleaned!"
