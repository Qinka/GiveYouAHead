--FP
module Common.Functions.FP where

findKey ::  [(String,String)]                       --key
        ->  String          --map
        ->  String


getFilesMainName :: String -> String --is with dot

getFilesMainName = reverse.dropWhile (/= '.') . reverse


linkStringList ::[[String]] -> [String]
linkStringList = concat

findKey [] key = key
findKey ((k,s):xs) key
                   | key == k = s
                   | otherwise = findKey xs key


