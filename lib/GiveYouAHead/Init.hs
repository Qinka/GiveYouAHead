




module GiveYouAHead.Init
    (
    init
    ) where

      import Prelude hiding (init)
      import System.Directory(doesDirectoryExist,createDirectory)

      init :: IO()
      init = do
        doesDirectoryExist ".gyah" >>= (\x -> if x then error "GiveYouAHead: Init: There had been initialized one."
          else createDirectory ".gyah")
        putStrLn "\nInitialized!\n"
