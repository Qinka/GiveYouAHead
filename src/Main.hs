--IO
module Main (main)where

import System.Environment
--import System.IO

import Help
import New
import Clean
import Build
import Settings

main :: IO ()
main =  do
    args <- getArgs
    case length args of
        0 -> helpMain
        _ -> doMain

doMain :: IO ()
doMain = do
    (cmd:xs) <-getArgs
    case cmd of
        "new"           -> if length xs >= 2 then newMain else helpMain
        "build"         -> if length xs >= 2 then buildMain else helpMain
        "clean"         -> if length xs <= 0 then cleanMain else helpMain
        "setting"       -> if length xs == 3 then settingMain else helpMain
        "help"          -> helpMain
        _               -> helpMain

