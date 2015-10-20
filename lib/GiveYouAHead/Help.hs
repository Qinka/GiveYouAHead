




module GiveYouAHead.Help
    (
    helpInfo
    ) where

      import System.Environment(getProgName)
      import GiveYouAHead.Version(gyahver)

      helpInfo :: IO()
      helpInfo = getProgName >>= (putStrLn.unlines.helpAll)
        where
          helpAll pN = [
            "\n",
            "GiveYouAHead\t\t\t version "++gyahver,
            "\tUsage :",
            "The details of usage are in the documents.And you can find more information at this repo's README.md . The links are at the bottom.\n",
            "\tTo create a new file",
            "\t\t"++pN++" new (optional){-t [template] -d [directory]} [id/name] [the list of import]",
            "\n",
            "\tTo initialize a new \"project\"",
            "\t\t"++pN++" init (optional){-d [directory]}",
            "\n",
            "\tTo build something",
            "\t\t"++pN++" build (optional){-t [template] -d [directory]} [the list of id/name]",
            "\n",
            "\tTo clean the temporary files",
            "\t\t"++pN++" clean (optional){-t [template]}",
            "\n",
            "\tTo configure",
            "\t\tTo list all the CommandMap in the .gyah",
            "\t\t"++pN++" config listcm",
            "\t\tTo add CommandMaps to a cm-file",
            "\t\t"++pN++" config addcm [flie-name] [cm-lists]",
            "\t\tTo delete (a) CommandMap(s) ",
            "\t\t"++pN++" config delcm [the ids' list of the cm]",
            "\t\tTo change CommandMap's status",
            "\t\t"++pN++" config turncm [file-name] [the list of ids] ",
            "\t\tTo change a cm's text",
            "\t\t"++pN++" config chcm [file-name] [id] [text]",
            "\n\n",
            "\tGiveYouAHead's repo : https://github.com/Qinka/GiveYouAHead",
            "\tGiveYouAHead had upload to Havkage: http://hackage.haskell.org",
            "\tBug report: https://github.com/Qinka/GiveYouAHead/issues",
            "\tLICENSE? BSD3",
            ""
            ]
