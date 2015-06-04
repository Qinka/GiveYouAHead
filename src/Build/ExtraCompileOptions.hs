--IO & FP
module Build.ExtraCompileOptions where

import System.IO

getOptions :: String        --noteMark
           -> String        --optionBegin
           -> String        --optionEnd
           -> [String]      --file text
           -> String        --options

getFileOptions :: String      --noteMark
               -> String      --opBegin
               -> String      --opEnd
               -> FilePath    --filepath
               -> IO String   --rt

delNoteMark :: String       --notemark
            -> String
            ->String

getOptBegin :: String           --option begin text
            -> [String]         --file
            -> [String]         --rt
getOptEnd   :: String           --option end text
            -> [String]         --file
            -> [String]         --rt


getFileOptions nM oB oE fn = do
    fSrc <- readFile fn
    return (getOptions nM oB oE (lines fSrc))



getOptBegin oB inStr = rt
    where
        (_:rt) = dropWhile (/= oB) inStr

getOptEnd oE inStr = rt
    where
        rt = takeWhile (/=oE) inStr

getOptions nM oB oE inStr = delNoteMark nM (concat it)
    where
        makeIt = getOptEnd (nM++oE).getOptBegin (nM ++ oB)
        it = makeIt inStr

delNoteMark [] str = str
delNoteMark _ [] = error "why?"
delNoteMark (n:nM) (s:str)
    | n == s = delNoteMark nM str
    | otherwise = error "!why?"


