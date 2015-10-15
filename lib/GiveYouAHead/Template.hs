




module GiveYouAHead.Template
    (
    getCM,
    getTemplate
    ) where



      import GiveYouAHead.Common(readF)
      import Data.GiveYouAHead(toTemplate,Template,CommandMap)
      import System.Directory(doesFileExist)



      getCM :: Bool -> IO CommandMap
      getCM ignoreDS= do
        ds <- getDS ignoreDS ".gyah/defaultSuffix.commandmap"
        (>>=return.read)$ readF $ ".gyah/commandmap" ++ ds

      getTemplate :: Bool -> String -> IO [Template]
      getTemplate ignoreDS name = do
        defaultSuffix <- getDS ignoreDS ".gyah/defaultSuffix.template"
        (>>= return.toTemplate.concatMap (getWordsStep.words.(++" \\n").takeWhile (/='%')).lines) $ readF $ ".gyah/template/"++name++defaultSuffix

      getWordsStep :: [String] -> [String]
      getWordsStep [] = []
      getWordsStep [x] = [x]
      getWordsStep (x:xs) = x:"\\space":getWordsStep xs

      getDS :: Bool -> String -> IO String
      getDS ignoreDS file = doesFileExist file >>= (\x -> if x && ignoreDS then readF file else return "")
