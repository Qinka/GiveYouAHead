--IO
module Help where

--outside
import System.Environment

helpMain ::IO()

helpMain = do
    progName <- getProgName
    putStrLn $ unlines [
        "中文测试??!!grg",
        "\tGiveYouAHead\t\t\t previous version 0.1.1.0 ",
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
