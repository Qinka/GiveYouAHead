




module Macro.MacroParser
    (
    textE,
    macroE,
    MacroNode(..),
    getEither,
    toMacro
    ) where

      import Text.Parsec(Parsec,many,noneOf,char,space,(<|>),parse,oneOf,anyChar,string)
      --import Control.Applicative(some)

      data MacroNode = Text String
                     | Macro String
                     | MacroDef String String
                     | Include FilePath
                     | List String [String]
                     | Lister String
                     | Flag String [(String,String)]
                     deriving (Eq)

      instance Show MacroNode where
        show (Text a) = a
        show (MacroDef a b) = "MacroDefiniton " ++ a ++ " -> " ++ b
        show (Include a) = "Included file: " ++ a
        show (Macro a) = "Macro "++a
        show (List a b) = "List " ++ a ++ " = " ++ show b
        show (Lister s) = "List maker " ++ s
        show (Flag a cases) = "Flag "++a++"=="++show cases



      toMacro :: String -> [MacroNode]
      toMacro = getEither.parse textE "error all".(++"\0")

      getEither :: Show b => Either b a -> a
      getEither (Right x) = x
      getEither (Left x) = error $ show x


      textE :: Parsec String () [MacroNode]
      textE = do
        text <- many (noneOf "\\\0") <* (char '\\' <|> char '\0')
        others <- many $ macroE <|> textE
        return $ mconcat $ [Text text]:others

      macroE :: Parsec String () [MacroNode]
      macroE = do
        macroName <- many (noneOf "\n {}\\\0") <* (char '\\' <|> space <|> char '{'<|> char '\0' <|> char ' ' <|> char '\n')
        case macroName of
          "def" -> do
            mde <- many macroDefE
            many (char ' ' <|> char '\n' <|> char '\0')
            others <- many $ textE <|> macroE
            return $ mconcat $ mde++others
          "list" -> do
            l <- many listE
            many (char ' ' <|> char '\n' <|> char '\0')
            others <- many $ textE <|> macroE
            return $ mconcat $ l++others
          "include" -> do
            file <- many (noneOf "\n}") <* char '}'
            many $ char '\n'
            -- many (char ' ' <|> char '\n' <|> char '\0')
            others <- many $ textE <|> macroE
            return $ mconcat $ [Include file]:others
          "lister" ->do
            s <- many (noneOf "}") <* char '}'
            many $ char '\n'
            -- <* oneOf "\n \0"  -- many (noneOf " \n\0") <* (char ' ' <|> char '\n' <|> char '\0')
            others <- many $ textE <|> macroE
            return $ mconcat $ [Lister s]:others
          "flag" -> do
            f <- many flagE
            others <- many $ textE <|> macroE
            return $ mconcat $ f++others
          _ -> do
            others <- many $ textE <|> macroE
            return $ mconcat $ [Macro macroName]:others


      flagE :: Parsec String () [MacroNode]
      flagE = do
        flagName <- char '{' *> many (noneOf "\n {}\\\0") <* char '}'
        cases <- many (caseE <|> flagEndE)
        many $ char '\n'
        others <- many $ textE <|> macroE
        return $ mconcat $ [Flag flagName $ concat cases]:others

      caseE,flagEndE :: Parsec String () [(String,String)]
      caseE = do
        caseName <- many (noneOf "}") <* char '}'
        caseText <- string "\\case{" *> many anyChar
        othercases <- many $ caseE <|> flagEndE
        return $ concat $ [(caseName,caseText)]:othercases

      flagEndE = do
        _ <- string "\\endflag"
        return []

      macroDefE :: Parsec String () [MacroNode]
      macroDefE = do
        macroName <- many (noneOf " {}\\\0") <* char '{'
        macroText <- many (noneOf "}") <* char '}'
        many $ char '\n'
        others <- many $ textE <|> macroE
        return $ mconcat $ [MacroDef macroName macroText]:others

      listE :: Parsec String () [MacroNode]       -- 不推荐定义 list
      listE = do
        listName <- many (noneOf "{}\\\0") <* char '}'
        listText <- many (noneOf "}") <* char '}'  --换行分割
        many $ char '\n'
        others <- many $ textE <|> macroE
        return $ mconcat $ [List listName $ lines $ tail listText]:others
