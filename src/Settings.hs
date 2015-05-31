--IO

module Settings  where

import Common.Functions.IO
import Settings.Data

--import System.IO



getSetting :: IO Setting
getSetting = do
    gP <- getProgDir
    stSrc <- readFile (gP++"Data/Setting.dat")
    return (read stSrc ::Setting)
