




module GiveYouAHead.Config
    (
    getDirectory,
    getTemplateDirectory
    ) where

      import GiveYouAHead.Common()


      getTemplateDirectory :: IO String
      getTemplateDirectory = return ".gyah/template"

      getDirectory :: IO String
      getDirectory = return ".gyah"
