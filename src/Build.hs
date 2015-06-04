--IO
module Build where

import Build.FilesList
import Build.ExtraCompileOptions
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

returnExtras :: String -> String ->String -> [String] -> IO [String]
returnExtras _ _ _ [] = return []
returnExtras nM oB oE (x:xs) = do
    rt <- getFileOptions nM oB oE x
    x <- returnExtras nM oB oE xs
    return (rt:x)


buildMain = do
    (_:lang:isDB:list) <- getArgs
    gC <- getDirectoryContents "."
    gDD <- getDataDir
    setting <- getSetting
    shCMap <- getCmdMap (gDD ++ "/data/shell/"++shell setting ++ ".cmap")
    lCMap <- getCmdMap (gDD ++ "/data/language/"++lang++".cmap")
    let
        allMap' = lCMap ++ shCMap ++ []
        files = case list of
                 [] -> getFilesList (findKey lCMap "*FE") gC
                 _ -> getFilesList (findKey lCMap "*FE") (map list' list)
        list' theid=concat $ map (findKey lCMap) ["*SrcAhead", fileName setting, theid, "*SrcBack"]
       in
       do
          extras <- returnExtras (findKey lCMap "*NoteMark") (findKey lCMap "*COB") (findKey lCMap "*COE") files
          let allMap = allMap' ++ (zip (map ("*extra"++) files) extras) in do
            putStrLn $ show files
            writeFile
                (concat $ map (findKey allMap) [".makefile", "*ShellFileBack"])
                (concat $
                    map (findKey allMap) (makeMakeFile (read isDB :: Bool) files))
            _ <- SP.createProcess $
                 SP.shell
                   (concat $
                      map (findKey allMap)
                        ["*SysShellRun", " ", ".makefile", "*ShellFileBack"])
            return ()






makeMakeFileStep isDebug fName=
    ["*Compiler"," ",(if isDebug then "*Debug" else " ")," ","*Object"," ",(getFilesMainName fName),"*ExecutableFE"," ",fName," ","*extra"++fName,"\n"]

makeMakeFile isDebug files =
    ["*MakefileBegin","\n"] ++ (linkStringList makes)++["*MakefileEnd"]
    where
        makes = map (makeMakeFileStep isDebug) files


