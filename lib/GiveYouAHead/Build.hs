




module GiveYouAHead.Build
    (
    build
    ) where

      import System.Directory(getDirectoryContents,doesFileExist)
      import System.Process(createProcess,shell,waitForProcess)

      import GiveYouAHead.Common(getDataDir,writeF,readF)
      --import GiveYouAHead.Template(getCM,getTemplate)
      import GiveYouAHead.Build.File(getFilesList,getOptionsFromFile)
      import Data.GiveYouAHead(findKey,toText,Switch(..),USettings(..),CommandMap)
      import Data.GiveYouAHead.JSON(getUSettings)
      import Macro.MacroParser()
      import Macro.MacroIO()
      import Macro.MacroReplace()

      build :: String -- build template if null means default
            -> [String] -- list
            -> [Bool]  -- commandmap's, template's
            -> IO()

      build tp list' (idscm:idst:_)= do
        ignore <- readIgnore ".gyah/build.ignore"
        us' <- getDataDir >>= (getUSettings.(++"/usettings"))
        let (Just us) =us'
        cc <- getDirectoryContents "."
        mnode <- getMacroFromFile idst $ if null tp then "build.default" else "build." ++ tp
        btstep <- getTemplate idst $ if null tp then "build.step.default" else "build.step." ++ tp
        eolist <- getEO cc cm ignore
        writeF (".makefile" ++ findKey cm "ShellFileBack" ) $ (concat.toText (cm' cm btstep eolist)) bt
        (_,_,_,pHandle) <- createProcess $ shell $ sysShell us ++ " .makefile" ++ findKey cm "ShellFileBack"
        _ <- waitForProcess pHandle
        return ()
        where
          list ccontents cmdMap ignore=
            if null list' then
              delIgnore (lines ignore) $ getFilesList (findKey cmdMap "FE") ccontents
              else getFilesList (findKey cmdMap "FE") $ map ((++ findKey cmdMap "numRight").(findKey cmdMap "numLeft" ++)) list'
          cm' cm bts eo= (On,"build",unlines $ map (\(x,y)->concat $ toText ((On,"file",x):(On,"eo",y):cm) bts) eo):cm
          delIgnore _ [] = []
          delIgnore is (x:xs)
            | x `elem` is = delIgnore is xs
            | otherwise = x : delIgnore is xs
          readIgnore x = do
            y <- doesFileExist x
            if y then readF x else return ""
          getEO :: [String] -> CommandMap -> String -> IO [(String,String)]
          getEO cc cm ig =
            l $ list cc cm ig
            where
              l :: [String] -> IO [(String,String)]
              l [] = return []
              l (x:xs) = do
                rt <- getOptionsFromFile
                  (findKey cm "notemark")
                  (findKey cm "eobegin")
                  (findKey cm "eoend")
                  x
                sx <- l xs
                return (rt:sx)

      build _ _ _ =undefined
