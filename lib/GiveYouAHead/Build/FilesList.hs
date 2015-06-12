--FP
module GiveYouAHead.Build.FilesList where

getFilesList :: String                                                          --file extension
             -> [String]                                                        --dir files list
             -> [String]                                                        --files list

getFilesList _ [] = []
getFilesList fe (x:xs)
    | x'fe x == fe = x:getFilesList fe xs
    | otherwise = getFilesList fe xs
    where
        x'fe = reverse . takeWhile (/= '.') . reverse
