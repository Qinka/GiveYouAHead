




module Macro.MacroParser
    (
    textE,
    macroE,
    macroDefE
    ) where

      import Text.Parsec
      --import Control.Applicative(some)

      data MacroNode = Text String
                     | Macro String
                     | MacroDef String String
                     | Include FilePath
                     | List String [String]
                     | Lister String
                     deriving (Eq,Show)

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
        macroName <- many letter <* char '{'
        macroText <- many (noneOf "}") <* char '}'
        others <- many $ textE <|> macroE
        return $ mconcat $ [MacroDef macroName macroText]:others
