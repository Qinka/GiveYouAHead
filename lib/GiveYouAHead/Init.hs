




module GiveYouAHead.Init
    (
    init
    ) where

      import Prelude hiding (init)

      import System.Directory(doesDirectoryExist,createDirectory)
      import Control.Monad(unless)


      init :: IO()
      init = do
        doesDirectoryExist ".gyah" >>= (\x -> if x then error "GiveYouAHead: Init: There had been initialized one."
          else createDirectory ".gyah")
        doesDirectoryExist ".gyah/template" >>= (\x-> unless x $ createDirectory ".gyah/template")
        putStrLn "\nInitialized!\n"
