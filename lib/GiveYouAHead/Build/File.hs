




module GiveYouAHead.Build.File
    (
    getFilesList,
    getOptions,
    getOptEnd,
    getOptBegin,
    getOptionsFromFile,
    eoBE,
    eoEE,
    extraOptionGet,
    emptyE
    ) where

      import GiveYouAHead.Common(readF)
      import Control.Monad
      import Text.Parsec

      extraOptionGet ::  (String,String,String) -> String -> Either ParseError String
      extraOptionGet (a,b,c) = parse (eoBE a b c <|> emptyE a b c) "error" 

      eoBE :: String -> String -> String -> Parsec  String () String -- commitmark,,ob oe
      eoBE c b e = do
        st <- string c *> many (noneOf "\n") <* char '\n'
        if st == b then
            liftM concat $ many $ eoEE c b e
          else
            liftM concat $ many $ eoBE c b e

      emptyE :: String -> String -> String -> Parsec  String () String
      emptyE c b e =do
        _ <- many (noneOf "\n")  <* char '\n'
        other <- many $ eoBE c b e <|> (many (noneOf "\n")  <* char '\n')
        return $ concat other


      eoEE :: String -> String -> String -> Parsec String () String
      eoEE c b e = do
        st <- string c *> many (noneOf "\n") <* char '\n'
        if st == e then em else el st
        where
          em = do
            _ <- many anyChar
            return ""
          el st= do
            other <- many $ eoEE c b e <|> emptyE c b e
            return $ concat $ st:other



      getFilesList :: String       -- file extension
                   -> [String]     -- dir files list
                   -> [String]     -- files list
      getFilesList _ [] = []
      getFilesList fe (x:xs)
        | xfe x == fe = x:getFilesList fe xs
        | otherwise = getFilesList fe xs
        where
          xfe = reverse .takeWhile (/= '.') .reverse


      getOptions :: String    -- note mark
                 -> String    -- option begin
                 -> String    -- option end
                 -> [String]  -- lined file's text
                 -> String
      getOptions nM oB oE inStr = delNoteMark nM $ concat items
        where
          makeItems = getOptEnd (nM ++ oE) . getOptBegin (nM ++ oB)
          items = makeItems inStr

      getOptionsFromFile :: String      -- note mark
                         -> String      -- option begin
                         -> String      -- option end
                         -> FilePath
                         -> IO (String,String) -- filename,eo
      getOptionsFromFile nM oB oE fn=
        readF fn >>= return . (\x-> (fn,x)) . getOptions nM oB oE .lines

      delNoteMark :: String {- note mark -} -> String -> String
      delNoteMark [] str = str
      delNoteMark _ [] = []
      delNoteMark (n:nM) (s:str)
        | n == s = delNoteMark nM str
        | otherwise = s:str

      getOptBegin :: String -> [String] -> [String]
      getOptBegin oB inStr = rt
        where
          rt' = dropWhile (/=oB) inStr
          (_:rt) = case length rt' of
            0 -> ["",""]
            1 -> ["",""]
            _ -> rt'

      getOptEnd ::String -> [String] -> [String]
      getOptEnd oE = takeWhile (/=oE)
