




module Macro.MacroIO
    (
    getMacroFromFile,
    getInclude
    ) where

      import Text.Parsec()
      import System.Directory(doesFileExist)
      import Control.Monad(liftM)

      import Macro.MacroParser(MacroNode(..),toMacro)
      import GiveYouAHead.Common(readF,getDataDir)


      getMacroFromFile :: FilePath -> IO [MacroNode]
      getMacroFromFile fn' =
        (>>= getInclude.toMacro.unlines.map (takeWhile (/='%')).lines) $ (>>= readF) fn
        where
          fn = do
            isE <- doesFileExist $ ".gyah/" ++ fn'
            if isE then
                return $ ".gyah/" ++ fn'
              else do
                isE' <- getDataDir >>= doesFileExist.(++"/"++fn')
                if isE' then
                    liftM (++"/"++fn') getDataDir
                  else
                    error $ "macro: can not find file : "++fn'

      getInclude :: [MacroNode] -> IO [MacroNode]
      getInclude [] = return []
      getInclude (Include fn:ms) = do
        im <- getMacroFromFile fn
        nm <- getInclude ms
        return $ im++nm
      getInclude (m:ms) =
        liftM (m:) $ getInclude ms
