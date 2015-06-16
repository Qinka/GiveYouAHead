--IO
module  GiveYouAHead.Clean where

--outside
import qualified System.Process as  SP
import System.IO.Extra

--inside
import GiveYouAHead.Common
import Data.GiveYouAHead

cleanMain :: IO ()
makeCleanCmd :: [String]

makeCleanCmd = ["*Del"," ","*DelForce"," ","*DelQuite"," ","*delList"]


cleanMain = do
    gDD <- getDataDir
    setting <- getSettings $ gDD ++ "/settings.dat"
    ssCMap <- getCmdMap $ gDD ++ "/shell/"++sysShell setting ++ ".cmap"
    delListSrc <-readFileUTF8 $ gDD ++ "/delList.dat"
    let allCMap = ssCMap ++ [(On,"*delList",concatMap (" "++) (read delListSrc ::[String]) ) ]
    (_,_,_,hp) <- SP.createProcess $ SP.shell $ concatMap (findKey allCMap) makeCleanCmd
    _ <- SP.waitForProcess hp
    putStrLn "Cleaned!"
    return ()
