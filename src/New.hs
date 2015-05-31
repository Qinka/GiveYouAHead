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
    gP <- getProgDir
    time <- getClockTime
    otherM <- readFile (gP ++"Data/"++lang++"/other.cmap")
    noteM <- readFile (gP ++"Data/"++lang++"/note.cmap")
    importM <-readFile (gP ++"Data/"++lang++"/import.cmap")
    templateM <- readFile (gP ++"Data/"++lang++"template.cmap")
    otherCMap <- getCmdMap otherM
    noteCMap <- getCmdMap noteM
    importCMap <- getCmdMap importM
    tplCMap <- getCmdMap templateM
    let allCMap = otherCMap ++ noteCMap ++ importCMap ++ tplCMap ++[("*noteMarkLine",(concat $ take 30 $ repeat (findKey noteCMap "*NoteMark"))),("*timeLine","\t Created tIme\t:\t"++(show time)) ]in
        writeFile (concat $ map (findKey allCMap) ["*SrcAhead",fileName setting,idNum,"*SrcBack"]) (concat $ getSrc allCMap iL)
    return ()


getSrc :: [(String,String)] -> [String]-> [String]
getSrc ncMap iL=
    map (addNoteMark (findKey ncMap "*NoteMark") ) (noteText ++ importText ++ templateText)
    where
        noteText =  map (addNoteMark (findKey ncMap "*NoteMark")) (map (findKey ncMap) makeNotes)
        importText = ((map (findKey ncMap)).linkStringList.(map addImport)) iL
        templateText = map (findKey ncMap) templateList
