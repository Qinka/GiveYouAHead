




module Data.GiveYouAHead
    (
      USettings(..),
      turnSwitch,
      findKey,
      delNewLine,
      getCmdMap,
      changeSwitchStatus,
      Switch(..)
    ) where

      import GiveYouAHead.Common

      data Switch = Off | On
          deriving (Show,Read,Eq,Ord)

      turnSwitch :: Switch -> Switch
      turnSwitch On = Off
      turnSwitch Off = On

      type CommandMap = [(Switch,String,String)]

      findKey :: CommandMap -> String -> String
      findKey [] key = key
      findKey ((On,k,v):xs) key
        | key == k =v
        |otherwise = findKey xs key
      findKey (_:xs) key = findKey xs key

      delNewLine ::String -> String
      delNewLine = concat.lines

      getCmdMap :: FilePath -> IO CommandMap
      getCmdMap = (>>= return.read.delNewLine).readF


      changeSwitchStatus :: CommandMap                -- map
                         -> String                    -- key
                         -> Int                       -- count or index
                         -> CommandMap

      changeSwitchStatus [] _ _ = []
      changeSwitchStatus ((s,k,v):xs) key c
        | key == k = if c==0 then(turnSwitch s,k,v):xs else (s,k,v):changeSwitchStatus xs key (c-1)
        | otherwise =(s,k,v):changeSwitchStatus xs key c


      data USettings = USettings{
          sysShell ::String
        }
