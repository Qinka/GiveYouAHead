--IO

module GiveYouAHead.Settings  where

--outside
import Control.Monad
import System.IO

--inside
import GiveYouAHead.Common
import Data.GiveYouAHead




getSetting :: IO Settings
getSetting = do
    gDD <- getDataDir
    stSrc <- readFile (gDD++"/data/setting.dat")
    return (read stSrc ::Settings)

settings :: IO ()
settings = do
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
    let st = read stSrc :: Settings
    hClose hD
    let
        sh' = if sh == "_" then dfShell st else sh
        fn' = if fn == "_" then dfFileName st else fn
        ss' = if ss == "-" then sysShell st else ss
        in
            writeFile (gDD ++ "/data/setting.dat") (show (Settings sh' fn' ss'))
    return ()

cmdSwitchSetting (fileName:key:count':_) = do
    gDD <- getDataDir
    iCMap <- getCmdMap (gDD ++ fileName)
    let count = read count' :: Int
    writeFile (gDD ++ fileName) (show $ changeSwitchStatus iCMap key count)
    return ()
