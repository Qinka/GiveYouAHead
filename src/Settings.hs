--IO

module Settings  where

import Common.Functions.IO
import Settings.Data
import System.Environment

import System.IO



getSetting :: IO Setting
getSetting = do
    gDD <- getDataDir
    stSrc <- readFile (gDD++"/data/setting.dat")
    return (read stSrc ::Setting)

settingMain:: IO ()
settingMain = do
    (_:sh:fn:ss:_) <- getArgs
    gDD <- getDataDir
    hD <- openFile (gDD++"/data/setting.dat") ReadMode
    stSrc <- hGetLine hD
    st <-  return (read stSrc ::Setting)
    hClose hD
    let
        sh' = if sh == "_" then shell st else sh
        fn' = if fn == "_" then fileName st else fn
        ss' = if ss == "_" then sysShell st else ss
        in do
            writeFile (gDD ++ "/data/setting.dat") (show (Setting sh' fn' ss'))
    return ()

