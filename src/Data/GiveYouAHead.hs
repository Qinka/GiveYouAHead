-----------------------------------------------------------------------------
--
-- Module      :  Data.GiveYouAHead
-- Copyright   :  2015 (C) Qinka <qinka@live.com>
-- License     :  AllRightsReserved
--
-- Maintainer  :  qinka@live.com
-- Stability   :  GiveYouAHead

-----------------------------------------------------------------------------


module Data.GiveYouAHead (

) where

import System.IO.Extra
import System.Directory

--del List

type DelList = [String]

readList :: IO DelList

addGlobalList :: [String] -> IO()
addCurList::[String] -> IO()

delGlobalList :: String->IO()
delCurList::String->IO()



readList = do
    udd <- getAppUserDataDirectory "GiveYouAHead"
    globalItem <- readFile (udd ++ "/delList")
    curItem <- readFile "./.gyah/delList"
    let allItem = words $ globalItem ++ curItem
    return allItem

addGlobalList x = do
    udd <- getAppUserDataDirectory "GiveYouAHead"
    hFile <- openFile (udd ++ "/delList") ReadWriteMode
    hSeek hFile SeekFromEnd 0
    hPutStrLn hFile $ unwords x
    hClose hFile
    return ()

addCurList x =do
    hFile <- openFile "./.gyah/delList" ReadWriteMode
    hSeek hFile SeekFromEnd 0
    hPutStrLn hFile $ unwords x
    hClose hFile
    return ()

delGlobalList delOne =do
    udd <- getAppUserDataDirectory "GiveYouAHead"
    allText <- readFile $ udd ++ "/delList"
    let rt = delItem $ words allText
    writeFile (udd++"/delList") $ unwords rt
    return ()
    where
        delItem [] = []
        delItem (x:xs) = if x == delOne then delItem xs else x:delItem xs

delCurList delOne = do
    allText <- readFile "./.gyah/delList"
    let rt = delItem $ words allText
    writeFile "./.gyah/delList" $ unwords rt
    return ()
    where
        delItem [] = []
        delItem (x:xs) = if x == delOne then delItem xs else x:delItem xs


