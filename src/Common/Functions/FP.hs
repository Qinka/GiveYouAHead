--FP
module Common.Functions.FP where

findKey ::  [(String,String)]                       --key
        ->  String          --map
        ->  String


getFilesMainName :: String -> String --is with dot

getFilesMainName = reverse.(dropWhile (\x -> x/='.')).reverse


linkStringList ::[[String]] -> [String]
linkStringList [] = []
linkStringList (x:xs) = x ++ linkStringList xs

findKey [] key = key
findKey ((k,s):xs) key
                   | key == k = s
                   | otherwise = findKey xs key


