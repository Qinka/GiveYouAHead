--IO
module Build where

import Build.FilesList
import Common.Functions.FP
import Common.Functions.IO
import Settings
import Settings.Data

import System.Directory
import System.Environment
import qualified System.Process as  SP

makeMakeFileStep :: Bool                -- is DEBUG
                 -> String              -- file name
                 -> [String]
makeMakeFile    ::  Bool                -- isDebug
                ->  [String]            -- files list
                ->  [String]

buildMain :: IO ()

buildMain = do
    (_:lang:isDB:list) <- getArgs
    gC <- getDirectoryContents "."
    gP <- getProgDir
    setting <- getSetting
    shSrc <- readFile (gP ++ "Data/"++(shell setting)++".cmap")
    lSrc <- readFile (gP ++ "Data/"++lang++"/build.cmap")
    shCMap <- getCmdMap shSrc
    lCMap <- getCmdMap lSrc
    let
        allMap = lCMap ++ shCMap ++ []
        files = case list of
            [] -> getFilesList (concat $ map (findKey lCMap) ["*FE"]) gC
            _ -> getFilesList (concat $ map (findKey lCMap) ["*FE"]) (map list' list)
        list' theid= (concat $ map (findKey lCMap) ["*SrcAhead",fileName setting,theid,"*SrcBack"])
        in do
            writeFile (concat $ map (findKey allMap) [".makefile.","*ShellFileBack"]) (concat $ map (findKey allMap) (makeMakeFile (read isDB ::Bool) files))
            _ <- SP.createProcess $ SP.shell (concat $ map (findKey allMap) ["*SysShellRun"{- for system shell-} ," ",".makefile.","*ShellFileBack"])
            return ()






makeMakeFileStep isDebug fName =
    ["*Compiler"," ",(if isDebug then "*Debug" else " "),"*Object"," ",(getFilesMainName fName),"*ExecutableFE"," ",fName,"\n"]

makeMakeFile isDebug files =
    ["*MakefileBegin","\n"] ++ (linkStringList makes)++["*MakefileEnd"]
    where
        makes = map (makeMakeFileStep isDebug) files


