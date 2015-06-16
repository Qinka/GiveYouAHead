--IO

module GiveYouAHead.Build where


--outside
import System.Directory
import qualified System.Process as  SP
import GHC.IO.Exception
import System.IO.Extra

--inside
import GiveYouAHead.Build.FilesList
import GiveYouAHead.Build.ExtraCompileOption
import GiveYouAHead.Common
--import GiveYouAHead.Settings
import Data.GiveYouAHead


makeMakeFileStep :: Bool                -- is DEBUG
                 -> String              -- file name
                 -> [String]
makeMakeFile    ::  Bool                -- isDebug
                ->  [String]            -- files list
                ->  [String]

buildMain :: [String]                                                           --args
          -> IO ()

returnExtras :: String -> String ->String -> [String] -> IO [String]
returnExtras _ _ _ [] = return []
returnExtras nM oB oE (x:xs) = do
    rt <- getOptionsFromFile nM oB oE x
    z <- returnExtras nM oB oE xs
    return (rt:z)


buildMain (lang:isDB:list) = do
    gC <- getDirectoryContents "."
    gDD <- getDataDir
    setting <- getSettings $ gDD ++ "/settings.dat"
    shCMap <- getCmdMap $ gDD ++ "/shell/"++dfShell setting ++ ".cmap"
    lCMap <- getCmdMap $ gDD ++ "/language/"++lang++".cmap"
    cpCMap <- getCmdMap $ gDD ++ "/compiler/" ++ findKey lCMap "*DefaultCompiler" ++".cmap"
    let allMap' = cpCMap ++ lCMap ++ shCMap ++ []
    let list' theid　=　concatMap (findKey lCMap) ["*SrcAhead", dfFileName setting, theid, "*SrcBack"]
    let files = case list of
                 [] -> getFilesList (findKey lCMap "*FE") gC
                 _ -> getFilesList (findKey lCMap "*FE") $　map list' list
    extras <- returnExtras (findKey lCMap "*NoteMark") (findKey lCMap "*COB") (findKey lCMap "*COE") files
    let allMap = allMap' ++ zip3 (repeat On) (map ("*extra"++) files) extras
    print files
    writeFileUTF8
        (concatMap (findKey allMap) [".makefile", "*ShellFileBack"])
        (concatMap (findKey allMap) (makeMakeFile (read isDB :: Bool) files))
    (_,_,_,hp) <- SP.createProcess $
        SP.shell　$
            concatMap (findKey allMap)
                ["*SysShellRun", " ", ".makefile", "*ShellFileBack"]
    exCode <- SP.waitForProcess hp
    let
        checkEC ExitSuccess = do
            putStrLn "Build Successfully."
        checkEC (ExitFailure id) =do
            putStrLn $ "Build failure.. the ExitCode is " ++ show id 
            in
                checkEC exCode
    return ()

buildMain _ = error "bad command!"

makeMakeFileStep isDebug fName=[
        "*Compiler",
        " ",
        if isDebug then "*Debug" else " ",
        " ",
        "*Object",
        " ",
        getFileMainName fName,
        "*ExecutableFE",
        " ",
        fName,
        " ",
        "*extra"++fName,
        "\n"]

makeMakeFile isDebug files =[
        "*MakefileBegin",
        "\n"] ++
        concat makes ++
        ["*MakefileEnd"]
    where
        makes = map (makeMakeFileStep isDebug) files
