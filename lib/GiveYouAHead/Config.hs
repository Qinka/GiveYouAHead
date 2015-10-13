




module GiveYouAHead.Config
    (
    getDirectory,
    getTemplateDirectory,
    addCommandMap,
    config
    ) where

      import GiveYouAHead.Common(writeF)
      import System.IO(openFile,IOMode(..),hGetLine,hClose,hIsEOF)
      import Data.GiveYouAHead(CommandMap,Switch(..))
      --import Control.DeepSeq(force)

      getTemplateDirectory :: IO String
      getTemplateDirectory = return ".gyah/template"

      getDirectory :: IO String
      getDirectory = return ".gyah"

      addCommandMap :: CommandMap -> IO ()
      addCommandMap cm =
        before >>= (after.show.(cm++).read)

      before :: IO String
      before = do
        h <- openFile ".gyah/commandmap" ReadMode
        rt <- getAll h
        hClose h
        return rt
        where
          getAll handle = do
            bool <- hIsEOF handle
            if bool then return ""
              else do
                new <- hGetLine handle
                other <- getAll handle
                return $ other++new


      after :: String -> IO ()
      after = writeF ".gyah/commandmap"

      config :: [String] -> IO ()
      config ("addcm":x:y:_) =
        addCommandMap [(On,x,y)]
      config ("ds":cm) = undefined
      config _ = undefined

      _ul :: [IO ()] -> IO ()
      _ul _ = return ()
