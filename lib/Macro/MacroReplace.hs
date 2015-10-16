




module Macro.MacroReplace
    (
    splitMacroDef,
    toText,
    findMacro
    ) where

      import Macro.MacroParser(MacroNode(..),toMacro)

      type MacroT = ([MacroNode],[MacroNode])
      --          macrodefiniton,macros


      splitMacroDefStep :: [MacroNode] -> ([MacroNode],[MacroNode]) -> ([MacroNode],[MacroNode])
      --                                macrodefiniton,macros
      splitMacroDefStep [] x = x
      splitMacroDefStep (x@(MacroDef _ _):xs) (as,bs) = splitMacroDefStep xs (x:as,bs)
      splitMacroDefStep (x@(List _ _):xs) (as,bs) = splitMacroDefStep xs (x:as,bs)
      splitMacroDefStep (x:xs) (as,bs) = splitMacroDefStep xs (as,x:bs)

      splitMacroDef :: [MacroNode] -> ([MacroNode],[MacroNode])
      --                            macrodefiniton,macros
      splitMacroDef xs = splitMacroDefStep xs ([],[])


      toText :: MacroT -> [MacroNode]
      toText (_,[]) = []
      toText (as,b@(Text _):bs) = b : toText(as,bs)
      toText (as,Macro x:bs)= toText (as,toMacro (findMacro as x)++bs)
      toText (as,Lister x:bs) = listerMake as $ m++toText (as,bs)
        where
          m = toMacro x
      toText (_,_) = error "macro,line 38,MacroReplace"

      findMacro :: [MacroNode] -> String -> String
      findMacro (MacroDef n t:xs) m
        | n==m = t
        | otherwise = findMacro xs m
      findMacro (List _ _:xs) m = findMacro xs m
      findMacro _ _ = error "error line 37,MacroReplace"


      listerMake :: [MacroNode] -> [MacroNode] -> [MacroNode]
      listerMake as (Macro b:bs)
        | isList as b = let (as',rt) = findList as b in toMacro rt ++ listerMake as' bs
        | otherwise = Macro b:listerMake as bs
        where
          isList [] _ = False
          isList (d:ds) c =case d of
            List x _-> x==c ||isList ds c
            _ -> isList ds c
          findList [] _ = error "error line 56,MacroReplace"
          findList (List n ms:ds) c
            | n == c = (List n (tail ms):ds,head ms)
            | otherwise = findList ds c
          findList (d:ds) c = let (ds',rt) = findList ds c in (d:ds',rt)
      listerMake _ [] = []
      listerMake _ _ = error "macro,line 63,MacroReplace"
