




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
      import Data.List(nub)


      getMacroFromFile :: FilePath -> IO [MacroNode]
      getMacroFromFile = (>>= return.snd).getMacroFromFileStep []


      getMacroFromFileStep :: [String] -> FilePath -> IO ([String],[MacroNode])
      getMacroFromFileStep list fn' =
        (>>= getInclude list.toMacro.unlines.map (takeWhile (/='%')).lines) $ (>>= readF) fn
        where
          fn = if filehead == "global" then fnb else fna
            where
              filehead = takeWhile (/='.') fn'
          fnb = do
            isE <- getDataDir >>= doesFileExist.(++"/"++fn')
            if isE then
                liftM (++"/"++fn') getDataDir
              else do
                isE' <- doesFileExist $ ".gyah/" ++ fn'
                if isE' then
                    return $ ".gyah/" ++ fn'
                  else
                    error $ "macro: can not find file : "++fn'
          fna = do
            isE <- doesFileExist $ ".gyah/" ++ fn'
            if isE then
                return $ ".gyah/" ++ fn'
              else do
                isE' <- getDataDir >>= doesFileExist.(++"/"++fn')
                if isE' then
                    liftM (++"/"++fn') getDataDir
                  else
                    error $ "macro: can not find file : "++fn'

      getInclude :: [String] -> [MacroNode] -> IO ([String],[MacroNode])
      getInclude list [] = return (list,[])
      getInclude list (Include fn:ms)
        | fn `elem` list = getInclude list ms
        | otherwise = do
          (list',im) <- getMacroFromFileStep (fn:list) fn
          (l,nm) <- getInclude list' ms
          return (nub $ list'++l,im++nm)
      getInclude list (m:ms) =
        liftM (\(x,y)->(x,m:y)) $ getInclude list ms
