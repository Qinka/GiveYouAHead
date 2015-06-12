--IO

module GiveYouAHead.New where

import GiveYouAHead.Settings
import GiveYouAHead.New.Import
import GiveYouAHead.New.Note
import GiveYouAHead.New.Template
import GiveYouAHead.Common

import Data.GiveYouAHead

import System.Environment
import System.Time





newMain :: [String]                                                            --args
         -> IO ()
newMain args@(lang:idNum:iL) = do
    gDD <- getDataDir
    settings <- getSettings $ gDD  ++ "/data/settings.dat"
    time <- getClockTime
    langCMap <- getCmdMap $ gDD ++ "/data/language/"++lang++".cmap"
    persionCMap <- getCmdMap $ gDD ++ "/data/persion.cmap"
    let allCMap = langCMap ++ persionCMap ++ [
            (On,"*noteMarkLine", concat $ replicate 30 $ findKey langCMap "*NoteMark" ),
            (On,"*timeLine","\tCreated tIme :\t"++show time),
            (On,"*probId",idNum)]
    writeFile  (concatMap (findKey allCMap) ["*SrcAhead",dfFileName settings,idNum,"*SrcBack"]) $ concat $ getSrc allCMap iL
    return ()

getSrc :: CommandMap -> [String] -> [String]
getSrc nMap iL =
    map f $ h noteText ++ importText iL ++ templateText
    where
        f = (++"\n") . g
        g = addNoteMark $ findKey nMap "*NoteMark"
        h = lines.concat
        noteText = map (findKey nMap) makeNotes
        importText = map (findKey nMap) . concat .map addImport
        templateText = map (findKey nMap) templateList
