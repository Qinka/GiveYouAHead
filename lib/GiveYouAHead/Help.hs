




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
            "\n",
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
            "\t\t"++pN++" config *undefined*",
            "\n\n",
            "\tGiveYouAHead's repo : https://github.com/Qinka/GiveYouAHead",
            "\tBug report: https://github.com/Qinka/GiveYouAHead/issues",
            ""
            ]
          t progName = [
            "\n",
            "\n\tGiveYouAHead\t\t\t version " ++ gyahver,
            "\tCommand :",
            "\tCreate a new file ",
            "\t\t"++progName++" new [language] [id] [the list of import]",
            "\tBuild the program(s) ",
            "\t\t"++progName++" build [language] [isDebug]",
            "\t\t"++progName++" build [language] [isDebug] [the list of id] ",
            "\tClean the directory's useless files",
            "\t\t"++progName++" clean",
            ""
            ]
