




module GiveYouAHead.Help
    (
    helpInfo
    ) where

      import System.Environment(getProgName)
      import GiveYouAHead.Version(gyahver)

      helpInfo :: IO()
      helpInfo = getProgName >>= (putStrLn.unlines.t)
        where
          helpAll pN = [
            "\n",
            "GiveYouAHead\t\t\t version "++gyahver,
            "\tUsage :",
            "\n",
            "\t\t"++pN++" new (optional){-t [template] -d [directory?} [id/name] [the list of import]",
            "",
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
     
