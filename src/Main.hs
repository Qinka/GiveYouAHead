--IO
module Main (main)where

import System.Environment
--import System.IO

import Help
import New
import Clean
import Build

main :: IO ()
main =  do
    args <- getArgs
    case length args of
        0 -> helpMain
        _ -> doMain

doMain :: IO ()
doMain = do
    (cmd:_) <-getArgs
    case cmd of
        "new"           -> newMain
        "build"         -> buildMain
        "clean"         -> cleanMain
        "help"          -> helpMain
        _               -> helpMain

