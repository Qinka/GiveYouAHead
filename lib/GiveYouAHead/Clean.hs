




module GiveYouAHead.Clean
    (
    clean
    ) where

      import System.Process(createProcess,shell,waitForProcess)
      import Data.GiveYouAHead(toText)
      import GiveYouAHead.Common()
      import GiveYouAHead.Template(getTemplate,getCM)


      clean :: [Bool]      -- commandmap's, template's 
            -> IO()

      clean (idscm:idst:_) = do
        cm <- getCM idscm
        t <- getTemplate idst "clean"
        (_,_,_,hp) <- createProcess $ shell $ concat $ toText cm t
        _ <- waitForProcess hp
        putStrLn "Cleaned!"
