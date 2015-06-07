--IO
module Clean where

--outside
import qualified System.Process as  SP
--import System.Environment

--inside
import Common.Functions.FP
import Common.Functions.IO
import Settings
import Settings.Data





cleanMain ::IO ()
makeCleanCmd :: [String]

makeCleanCmd = ["*Del"," ","*DelForce"," ","*DelQuite"," ","*delList"]


cleanMain = do
    gDD <- getDataDir
    setting <- getSetting
    ssCMap <- getCmdMap (gDD ++ "/data/shell/"++sysShell setting ++ ".cmap")
    delListSrc <-readFile (gDD ++ "/data/delList.dat")
    let allCMap = ssCMap ++ [("*delList",concatMap (" "++) (read delListSrc ::[String] )) ] in do
        _ <- SP.createProcess $ SP.shell $ concatMap (findKey allCMap) makeCleanCmd
        return ()
