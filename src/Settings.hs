--IO

module Settings  where

import Common.Functions.IO
import Settings.Data

--import System.IO



getSetting :: IO Setting
getSetting = do
    gDD <- getDataDir
    stSrc <- readFile (gDD++"/data/detting.dat")
    return (read stSrc ::Setting)
