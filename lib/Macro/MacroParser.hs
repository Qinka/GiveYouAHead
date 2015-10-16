




module Macro.MacroParser
    (
    textE,
    macroE,
    MacroNode(..),
    getEither,
    toMacro
    ) where

      import Text.Parsec(Parsec,many,noneOf,char,space,(<|>),parse)
      --import Control.Applicative(some)

      data MacroNode = Text String
                     | Macro String
                     | MacroDef String String
                     | Include FilePath
                     | List String [String]
                     | Lister String
                     deriving (Eq,Show)



      toMacro :: String -> [MacroNode]
      toMacro = getEither.parse textE "error"

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
        macroName <- many (noneOf " {}\\\0") <* (char '\\' <|> space <|> char '{'<|> char '\0')
        case macroName of
          "def" -> do
            mde <- many macroDefE
            others <- many $ textE <|> macroE
            return $ mconcat $ mde++others
          "list" -> do
            l <- many listE
            others <- many $ textE <|> macroE
            return $ mconcat $ l++others
          "include" -> do
            file <- many (noneOf "}") <* char '}'
            others <- many $ textE <|> macroE
            return $ mconcat $ [Include file]:others
          "lister" ->do
            s <- many (noneOf "}") <* char '}'
            others <- many $ textE <|> macroE
            return $ mconcat $ [Lister s]:others
          _ -> do
            others <- many $ textE <|> macroE
            return $ mconcat $ [Macro macroName]:others



      macroDefE :: Parsec String () [MacroNode]
      macroDefE = do
        macroName <- many (noneOf " {}\\\0") <* char '{'
        macroText <- many (noneOf "}") <* char '}'
        others <- many $ textE <|> macroE
        return $ mconcat $ [MacroDef macroName macroText]:others

      listE :: Parsec String () [MacroNode]       -- 不推荐定义 list
      listE = do
        listName <- many (noneOf "{}\\\0") <* char '{'
        listText <- many (noneOf "}") <* char '}'  --换行分割
        others <- many $ textE <|> macroE
        return $ mconcat $ [List listName $ lines listText]:others
