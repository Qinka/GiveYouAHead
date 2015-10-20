




module GiveYouAHead.Build
    (
    build
    ) where

      import System.Directory(getDirectoryContents,doesFileExist)
      import System.Process(createProcess,shell,waitForProcess)

      import GiveYouAHead.Common(getDataDir,writeF,readF)
      import GiveYouAHead.Build.File(getFilesList,getOptionsFromFile)
      import Data.GiveYouAHead(USettings(..))
      import Data.GiveYouAHead.JSON(getUSettings)
      import Macro.MacroParser(MacroNode(..))
      import Macro.MacroIO(getMacroFromFile)
      import Macro.MacroReplace(findMacro,splitMacroDef,toText)

      build :: String -- build template if null means default
            -> [String] -- list
            -> IO()

      build tp list' = do
        ignore <- readIgnore ".gyah/build.ignore"
        us' <- getDataDir >>= (getUSettings.(++"/usettings"))
        let (Just us) =us'
        cc <- getDirectoryContents "."
        mnode <- getMacroFromFile $ if null tp then "build.default" else "build." ++ tp
        bsnode <- getMacroFromFile "global.build.macros"
        let (as,bs) = splitMacroDef mnode
        (files,fileeos) <- getEO cc as ignore
        let bsmacro = fst $ splitMacroDef bsnode
        writeF (".makefile"++findMacro bsmacro "makefileBack") $ concatMap show $ toText (mn' as files fileeos,bs)
        (_,_,_,pHandle) <- createProcess $ shell $ sysShell us ++ " .makefile" ++ findMacro bsmacro "makefileBack"
        _ <- waitForProcess pHandle
        return ()
        where
          list ccontents mn ignore=
            if null list' then
              delIgnore (lines ignore) $ getFilesList (findMacro mn "FE") ccontents
              else getFilesList (findMacro mn "FE") $ map ((++ findMacro mn "numRight").(findMacro mn "numLeft" ++)) list'
          mn' mn files fileeos= List "files" files:List "fileeos" fileeos:mn
          delIgnore _ [] = []
          delIgnore is (x:xs)
            | x `elem` is = delIgnore is xs
            | otherwise = x : delIgnore is xs
          readIgnore x = do
            y <- doesFileExist x
            if y then readF x else return ""
          getEO :: [String] -> [MacroNode] -> String -> IO ([String],[String])
          getEO cc mn ig =
            l $ list cc mn ig
            where
              l :: [String] -> IO ([String],[String])
              l [] = return ([],[])
              l (x:xs) = do
                (rtx,rty) <- getOptionsFromFile
                  (findMacro mn "notemark")
                  (findMacro mn "eobegin")
                  (findMacro mn "eoend")
                  x
                (sx,sy) <- l xs
                return (rtx:sx,rty:sy)
