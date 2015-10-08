




module GiveYouAHead.Template
    (
    getCM,
    getTemplate
    ) where



      import GiveYouAHead.Common(readF)
      import Data.GiveYouAHead(toTemplate,Template,CommandMap)



      getCM :: IO CommandMap
      getCM = (>>=return.read)$ readF ".gyah/commandmap"

      getTemplate :: String -> IO [Template]
      getTemplate name = (>>= return.toTemplate.concatMap (getWordsStep.words).(map (++" \\n")).lines) $ readF $ ".gyah/template/"++name

      getWordsStep :: [String] -> [String]
      getWordsStep [] = []
      getWordsStep [x] = [x]
      getWordsStep (x:xs) = x:"\\space":getWordsStep xs
