




module GiveYouAHead.Build
    (
    build
    ) where

      import System.Directory(getDirectoryContents)
      import System.Process(createProcess,shell,waitForProcess)
      --import GHC.IO.Exception()

      import GiveYouAHead.Common(getDataDir,writeF)
      import GiveYouAHead.Template(getCM,getTemplate)
      import GiveYouAHead.Build.File(getFilesList)
      import Data.GiveYouAHead(findKey,toText,Switch(..),USettings(..))
      import Data.GiveYouAHead.JSON(getUSettings)

      build :: String -- build template if null means default
            -> [String] -- list
            -> IO()

      build tp list' = do
        us' <- getDataDir >>= (getUSettings.(++"/usettings"))
        let (Just us) =us'
        cc <- getDirectoryContents "."
        cm <- getCM
        bt <- getTemplate $ if null tp then "build.default" else "build." ++ tp
        btstep <- getTemplate $ if null tp then "build.step.default" else "build.step" ++ tp
        writeF (".makefile" ++ findKey cm "ShellFileBack" ) $ (concat.toText (cm' cm btstep cc)) bt
        (_,_,_,pHandle) <- createProcess $ shell $ sysShell us ++ ".makefile" ++ findKey cm "ShellFileBack"
        _ <- waitForProcess pHandle
        return ()
        where
          list ccontents cmdMap =
            if null list' then getFilesList (findKey cmdMap "FE") ccontents else getFilesList (findKey cmdMap "FE") list'
          cm' cm bts cc= (On,"build",unlines.map (\x->concat $ toText ((On,"file",x):cm) bts) $ list cc cm):cm
