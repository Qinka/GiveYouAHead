--IO
module GiveYouAHead where

import GiveYouAHead.New
import GiveYouAHead.Build
import GiveYouAHead.Clean
--import GiveYouAHead.Common
import GiveYouAHead.Help
--import Data.GiveYouAHead

gyahMain :: [String]
         -> IO ()

gyahMain args = case length args of
    0  -> help
    _  -> doGyah args

doGyah :: [String]
       -> IO ()
doGyah (cmd:xs) =
    case cmd of
        "new"           -> if length xs >= 2 then newMain xs else help
        "build"         -> if length xs >= 2 then buildMain xs else help
        "clean"         -> if null xs then clean else help
        "help"          -> help
        _               -> help
doGyah _ = error "bad command!"

gyah :: IO()
gyah = do
    args <- getLine
    gyahMain $ words args


help :: IO ()
help = helpMain

new :: IO ()
new = do
    args <- getLine
    if length args >= 2 then newMain  $ words args else help

build :: IO ()
build = do
    args <- getLine
    if length args >= 2 then buildMain  $ words args else help

clean :: IO()
clean = cleanMain
