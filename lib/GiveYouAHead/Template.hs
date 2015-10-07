




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
      getTemplate name = (>>= return.toTemplate.concatMap words.lines) $ readF $ ".gyah/template/"++name
