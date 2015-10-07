




module Parameter
    (
    Pm(..),
    toPm,
    argsToString,
    getOpt
    ) where

      data Pm = Option String String | Args String

      getOpt :: [Pm] -> String -> [String]
      getOpt [] _ = []
      getOpt (Option o s:xs) a
          | o == a = s : getOpt xs a
          | otherwise = getOpt xs a
      getOpt (Args _ :xs) a = getOpt xs a

      toPm :: [String] -> [Pm]
      toPm [] = []
      toPm (x:xs) =
        if head x == '-'
          then Option (getOptName x) (head xs) : toPm (tail xs)
          else Args x : toPm xs
        where
          getOptName ('-':y) = y
          getOptName ('-':'-':y) = y
          getOptName _ = error "Parameter: getOptName: Can not!"


      argsToString :: [Pm] -> [String]
      argsToString []  = []
      argsToString (Args x:xs) = x:argsToString xs
      argsToString (Option _ _ :xs) = argsToString xs
