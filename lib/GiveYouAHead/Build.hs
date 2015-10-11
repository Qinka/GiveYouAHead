




module GiveYouAHead.Build
    (
    build
    ) where

      import System.Directory(getDirectoryContents,doesFileExist)
      import System.Process(createProcess,shell,waitForProcess)
      --import GHC.IO.Exception()

      import GiveYouAHead.Common(getDataDir,writeF,readF)
      import GiveYouAHead.Template(getCM,getTemplate)
      import GiveYouAHead.Build.File(getFilesList)
      import Data.GiveYouAHead(findKey,toText,Switch(..),USettings(..))
      import Data.GiveYouAHead.JSON(getUSettings)

      build :: String -- build template if null means default
            -> [String] -- list
            -> [Bool]  -- commandmap's, template's
            -> IO()

      build tp list' (idscm:idst:_)= do
        ignore <- readIgnore ".gyah/build.ignore"
        us' <- getDataDir >>= (getUSettings.(++"/usettings"))
        let (Just us) =us'
        cc <- getDirectoryContents "."
        cm <- getCM idscm
        bt <- getTemplate idst $ if null tp then "build.default" else "build." ++ tp
        btstep <- getTemplate idst $ if null tp then "build.step.default" else "build.step." ++ tp
        writeF (".makefile" ++ findKey cm "ShellFileBack" ) $ (concat.toText (cm' cm btstep cc ignore)) bt
        (_,_,_,pHandle) <- createProcess $ shell $ sysShell us ++ " .makefile" ++ findKey cm "ShellFileBack"
        _ <- waitForProcess pHandle
        return ()
        where
          list ccontents cmdMap ignore=
            if null list' then
              delIgnore (lines ignore) $ getFilesList (findKey cmdMap "FE") ccontents
              else getFilesList (findKey cmdMap "FE") $ map ((++ findKey cmdMap "numRight").(findKey cmdMap "numLeft" ++)) list'
          cm' cm bts cc ignore= (On,"build",unlines.map (\x->concat $ toText ((On,"file",x):cm) bts) $ list cc cm ignore):cm
          delIgnore _ [] = []
          delIgnore is (x:xs)
            | x `elem` is = delIgnore is xs
            | otherwise = x : delIgnore is xs
          readIgnore x = do
            y <- doesFileExist x
            if y then readF x else return ""

      build _ _ _ =undefined
