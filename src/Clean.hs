--IO
module Clean where


import Common.Functions.FP
import Common.Functions.IO
import Settings
import Settings.Data

import qualified System.Process as  SP
--import System.Environment




cleanMain ::IO ()
makeCleanCmd :: [String]

makeCleanCmd = ["*Del"," ","*DelForce"," ","*DelQuite"," ","*DelList"]


cleanMain = do
    gDD <- getDataDir
    setting <- getSetting
    ssSrc <- readFile (gDD ++ "/data/shell"++sysShell setting ++ ".cmap")
    ssCMap <- getCmdMap ssSrc
    _ <- SP.createProcess $ SP.shell $ concatMap (findKey ssCMap) makeCleanCmd
    return ()

