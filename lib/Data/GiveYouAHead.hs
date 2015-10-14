




module Data.GiveYouAHead
    (
      USettings(..),
      CommandMap,
      turnSwitch,
      findKey,
      delNewLine,
      getCmdMap,
      changeSwitchStatus,
      Switch(..),
      Template(..),
      toTemplate,
      toText,
      delcm,
      chcm,
      turncm
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

      delcm :: [Int] -> CommandMap -> CommandMap
      delcm [] ys = ys
      delcm (x:xs) ys =
        let (as,bs) = splitAt x ys
        in delcm (plus x xs) $ as ++ if null bs then [] else tail bs

      chcm :: Int -> String -> CommandMap -> CommandMap
      chcm i t cm =
        if null bs then as else let ((x,y,_):xs)=bs in
          as++(x,y,t):xs
        where
        (as,bs) = splitAt i cm

      turncm :: Int -> CommandMap -> CommandMap
      turncm i cm =
        if null bs then as else let ((x,y,z):xs)=bs
          in as++(turnSwitch x,y,z):xs
        where
          (as,bs) = splitAt i cm

      plus :: Int -> [Int] -> [Int]
      plus _ [] = []
      plus x (y:ys)
        | x<y = y-1:ys
        |otherwise = y:ys


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


      data Template = Macro String | Text String | Space | LF deriving (Show,Read)

      toTemplate :: [String] -> [Template]
      toTemplate [] = []
      toTemplate (x:xs) = mark:toTemplate xs
        where
          ('\\':cmd) = x
          mark = case head x of
            '\\' -> case cmd of
              "n" -> LF
              "space" -> Space
              y -> Macro y
            _ -> Text x

      toText :: CommandMap -> [Template] -> [String]
      toText _ [] = []
      toText cm (Macro x:xs) = findKey cm x : toText cm xs
      toText cm (Text x:xs) = x : toText cm xs
      toText cm (LF:xs) = "\n":toText cm xs
      toText cm (Space:xs) = " ":toText cm xs
