--IO

module Settings  where

--outside
import Control.Monad
import System.Environment
import System.IO

--inside
import Common.Functions.IO
import Settings.Data
import Settings.Change




getSetting :: IO Setting
getSetting = do
    gDD <- getDataDir
    stSrc <- readFile (gDD++"/data/setting.dat")
    return (read stSrc ::Setting)

settingMain :: IO ()
settingMain = do
    putStrLn "GiveYouAHead settings shell"
    forever $ do
        putStr " Settings > "
        cmd <- getLine
        let (c:cmds) = words cmd
        case c of
            "base" -> baseSetting cmds
            "cmdmapswitch" -> cmdSwitchSetting cmds
            _ -> nullSetting cmds

baseSetting :: [String] -> IO ()
cmdSwitchSetting :: [String] -> IO ()
nullSetting :: [String] -> IO ()

nullSetting _  = do
    putStrLn "input error"            --输入的命令有误
    return ()

baseSetting (sh:fn:ss:_) = do
    gDD <- getDataDir
    hD <- openFile (gDD ++ "/data/setting.dat") ReadMode
    stSrc <- hGetLine  hD
    let st = read stSrc :: Setting
    hClose hD
    let
        sh' = if sh == "_" then shell st else sh
        fn' = if fn == "_" then fileName st else fn
        ss' = if ss == "-" then sysShell st else ss
        in
            writeFile (gDD ++ "/data/setting.dat") (show (Setting sh' fn' ss'))
    return ()

cmdSwitchSetting (fileName:key:id':_) = do
    gDD <- getDataDir
    iCMap <- getCmdMap (gDD ++ fileName)
    let id = read id' :: Int
    writeFile (gDD ++ fileName) (show $ changeSwitchStatus key iCMap id)
    return ()
