




module GiveYouAHead.Config
    (
    getDirectory,
    getTemplateDirectory,
    addCommandMap,
    config
    ) where

      import GiveYouAHead.Common(writeF,readF)
      import Data.GiveYouAHead(CommandMap)

      getTemplateDirectory :: IO String
      getTemplateDirectory = return ".gyah/template"

      getDirectory :: IO String
      getDirectory = return ".gyah"

      addCommandMap :: CommandMap -> IO ()
      addCommandMap cm =
        before >>= (after.show.(cm:).read)
        where
          before = readF ".gyah/commandmap"
          after = writeF ".gyah/commandmap"

      config :: [String] -> IO ()
      config ("addcm":cm) =
        _ul $ map (addCommandMap.read) cm
      config ("ds":cm) = undefined
      config _ = undefined

      _ul :: [IO ()] -> IO ()
      _ul _ = return ()
