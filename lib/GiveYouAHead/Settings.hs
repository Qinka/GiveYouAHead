--IO

module GiveYouAHead.Settings  where

--outside
import Control.Monad
import System.IO

--inside
import GiveYouAHead.Common
import Data.GiveYouAHead
import Data.List



getSetting :: IO Settings
getSetting = do
    gDD <- getDataDir
    stSrc <- readFile (gDD++"/setting.dat")
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
    putStrLn "input error"            --
    return ()

baseSetting (sh:fn:ss:_) = do
    gDD <- getDataDir
    hD <- openFile (gDD ++ "/setting.dat") ReadMode
    stSrc <- hGetLine  hD
    let st = read stSrc :: Settings
    hClose hD
    let
        sh' = if sh == "_" then dfShell st else sh
        fn' = if fn == "_" then dfFileName st else fn
        ss' = if ss == "-" then sysShell st else ss
        in
            writeFile (gDD ++ "/setting.dat") (show (Settings sh' fn' ss'))
    return ()
baseSetting _ = error "bad command!"

cmdSwitchSetting (fileName:key:count':_) = do
    gDD <- getDataDir
    iCMap <- getCmdMap (gDD ++ fileName)
    let count = read count' :: Int
    writeFile (gDD ++ fileName) (show $ changeSwitchStatus iCMap key count)
    return ()

cmdSwitchSetting _ = error "bad command!"
writeData :: FilePath                               -- %UAD%/GiveYouAhead/
          -> String                                 -- the things you want to write
          -> IO () 

writeData fpath' src = do
    gDD <- getDataDir
    let fpath = gDD ++ "/" ++ fpath'
    writeFile fpath src
    return ()

dropRepeated :: (Eq a)=> [a] -> [a]
dropRepeated [] = []
dropRepeated (x:[]) = [x]
dropRepeated (x:y:xs)
    | x == y = dropRepeated (x:xs)
    | otherwise = x:dropRepeated (y:xs)


dropDelListRepeatedAndAdd :: [String] -> IO ()
dropDelListRepeatedAndAdd xs = do
        dir <- getDataDir
        hD <- openFile (dir++"/delList.dat") ReadMode
        stSrc <- hGetLine hD
        hClose hD
        putStrLn stSrc
        writeFile (dir ++ "/delList.dat") $ show $ dropRepeated $ sort $ (++) xs (read stSrc ::[String])
        return ()