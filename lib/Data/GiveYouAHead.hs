--Data , IO , and FP

module Data.GiveYouAHead where

--import System.IO
import System.IO.Extra
--Switch

data Switch = Off | On
    deriving (Show , Read , Eq , Ord)



turnSwitch :: Switch -> Switch
turnSwitch On = Off
turnSwitch Off = On

--CommandMap

type CommandMap =  [(Switch,String,String)]   --switch key value

findKey :: CommandMap -> String -> String

findKey [] key = key
findKey ((On,k,v):xs) key
    | key == k = v
    | otherwise = findKey xs key
findKey (_:xs) key = findKey xs key


delNewLine :: String -> String
delNewLine = concat.lines

getCmdMap :: FilePath -> IO CommandMap

getCmdMap fpath = do
    src' <- readFileUTF8 fpath
    let src = delNewLine src'
    return (read src :: CommandMap)

changeSwitchStatus :: CommandMap                -- command map
                   -> String                    -- key
                   -> Int                       -- count or index
                   -> CommandMap

changeSwitchStatus [] _ _ = []
changeSwitchStatus ((s,k,v):xs) key c
    | key == k && c == 0 = (turnSwitch s,k,v):xs
    | key == k && c /= 0 = (s,k,v):changeSwitchStatus xs key (c-1)
    | otherwise = (s,k,v):changeSwitchStatus xs key c



--Settings
data Settings = Settings
    {
        dfShell ::String,
        dfFileName :: String,
        sysShell ::String
    } deriving (Read,Show)


getSettings :: FilePath
            -> IO Settings

getSettings fPath = do
    src <- readFileUTF8 fPath
    return (read src :: Settings)
