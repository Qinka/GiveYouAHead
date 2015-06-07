--FP
module Common.Functions.FP where

findKey ::  CmdMap                       --key
        ->  String          --map
        ->  String


getFilesMainName :: String -> String --is with dot

getFilesMainName = reverse . dropWhile (/= '.') . reverse


linkStringList ::[[String]] -> [String]
linkStringList = concat

findKey [] key = key
findKey ((s,k,v):xs) key      -- s status k key v value
                    | s==Off = findKey xs key
                    | key == k = s
                    | otherwise = findKey xs key
