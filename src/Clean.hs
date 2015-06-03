--IO
module Clean where


import Common.Functions.FP
import Common.Functions.IO
import Settings
import Settings.Data

import qualified System.Process as  SP
import System.Environment




cleanMain ::IO ()
makeCleanCmd :: [String]

makeCleanCmd = ["*Del"," ","*DelForce"," ","*DelQuite"," ","*DelList"]


cleanMain = do
    (_:lang:_) <- getArgs
    gDD <- getDataDir
    setting <- getSetting
    ssCMap <- getCmdMap (gDD ++ "/data/shell/"++sysShell setting ++ ".cmap")
    langCMap <- geyCmdMap (gDD ++ "/data/language/"++Lang++".cmap")
    let allCMap = ssCMap ++ langclap ++[] in
        _ <- SP.createProcess $ SP.shell $ concat $ map (findKey ssCMap) makeCleanCmd
    return ()

