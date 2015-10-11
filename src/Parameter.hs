




module Parameter
    (
    Pm(..),
    toPm,
    argsToString,
    getOpt,
    getFlag
    ) where

      data Pm = Option String String | Flag String | Args String

      getOpt :: [Pm] -> String -> [String]
      getOpt [] _ = []
      getOpt (Option o s:xs) a
          | o == a = s : getOpt xs a
          | otherwise = getOpt xs a
      getOpt (_:xs) a = getOpt xs a

      getFlag :: [Pm] -> String -> Bool
      getFlag [] _ = False
      getFlag  (Flag x:xs) a
        | x == a = True
        | otherwise = getFlag xs a
      getFlag (_:xs) a = getFlag xs a

      toPm :: [String] -> [Pm]
      toPm [] = []
      toPm (x:xs) =
        if head x == '-'
          then (if null $ getOptText x then Flag $ getOptName x else Option (getOptName x) (getOptText x)): toPm xs
          else Args x : toPm xs
        where
          getOptName ('-':y) = y
          getOptName ('-':'-':y) = y
          getOptName _ = error "Parameter: getOptName: Can not!"
          getOptText = tail.dropWhile (/='=')


      argsToString :: [Pm] -> [String]
      argsToString []  = []
      argsToString (Args x:xs) = x:argsToString xs
      argsToString (Option _ _ :xs) = argsToString xs
