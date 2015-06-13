--IO & FP

module GiveYouAHead.Build.ExtraCompileOption where

getOptions :: String                                                            --note mark
           -> String                                                            --option begin
           -> String                                                            --option end
           -> [String]                                                           --fileText
           -> String


getOptionsFromFile  :: String                                                   --note mark
                    -> String                                                   --option begin
                    -> String                                                   --option end
                    -> FilePath                                                 --fileText
                    -> IO String

delNoteMark :: String                                                           --note mark
            -> String
            -> String

getOptBegin :: String
            -> [String]
            -> [String]

getOptEnd   :: String
            -> [String]
            -> [String]


getOptionsFromFile nM oB oE fn = do
    fSrc <- readFile fn
    return $ getOptions nM oB oE $ lines fSrc

getOptBegin oB inStr = rt
    where
            rt = dropWhile (/=oB) inStr

getOptEnd oE inStr = rt
    where
        rt = takeWhile (/=oE) inStr

getOptions nM oB oE inStr = delNoteMark   nM $ concat items
    where
        makeItems = getOptEnd (nM ++ oE) . getOptBegin (nM ++ oB)
        items = makeItems inStr

delNoteMark [] str = str
delNoteMark _ [] = []
delNoteMark (n:nM) (s:str)
    | n == s = delNoteMark nM str
    | otherwise = error "!?!why?"
