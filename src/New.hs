--IO
module New where

import  New.Import
import  New.Note
import  New.Template
import  Common.Functions.FP
import  Common.Functions.IO
import  Settings
import  Settings.Data

import System.Environment
import System.Time

newMain :: IO ()

newMain = do
    setting <- getSetting
    (_:lang:idNum:iL) <- getArgs
    gDD <- getDataDir
    time <- getClockTime
    langM <- readFile (gDD ++"/data/language/"++lang++".cmap")
    personM <- readFile (gDD ++"/data/person.cmap")
    langCMap <- getCmdMap langM
    personCMap <- getCmdMap personM
    let allCMap = langCMap ++ personCMap ++[("*noteMarkLine",
                                              concat $ replicate 30 (findKey langCMap "*NoteMark")),("*timeLine","\t Created tIme\t:\t" ++ show time) ]in
        writeFile (concatMap (findKey allCMap)
                      ["*SrcAhead", fileName setting, idNum, "*SrcBack"]) (concat $ getSrc allCMap iL)
    return ()


getSrc :: [(String,String)] -> [String]-> [String]
getSrc ncMap iL=
    map (addNoteMark (findKey ncMap "*NoteMark") ) (noteText ++ importText ++ templateText)
    where
        noteText =  map (addNoteMark (findKey ncMap "*NoteMark") . findKey ncMap)
                       makeNotes
        importText = (map (findKey ncMap) . linkStringList . map addImport) iL
        templateText = map (findKey ncMap) templateList
