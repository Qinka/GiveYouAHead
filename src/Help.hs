--IO
module Help where

import System.Environment

helpMain ::IO()

helpMain = do
    progName <- getProgName
    putStrLn $ unlines [
        "\tGiveYouAHead\t\t\t previous version 0.1.0.2 ",
        "\tCommand :",
        "\tCreate a new file ",
        "\t\t"++progName++" new [language] [id] [the list of import]",
        "\tBuild the program(s) ",
        "\t\t"++progName++" build [language]",
        "\t\t"++progName++" build [language] [the list of id] ",
        "\tClean the directory's useless files",
        "\t\t"++progName++"clean",
        "",
        "\tHomepage https://github.com/Qinka/GiveYouAHead/",
        "\tBug report: https://github.com/Qinka/GiveYouAHead/issues",
        ""
        ]

