




module GiveYouAHead.Build.File
    (
    getFilesList,
    getOptions,
    getOptEnd,
    getOptBegin,
    getOptionsFromFile
    ) where

      import GiveYouAHead.Common(readF)


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
                         -> IO String
      getOptionsFromFile nM oB oE=
        (>>= return . getOptions nM oB oE .lines).readF

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
