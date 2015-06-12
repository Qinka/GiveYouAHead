--IO
module GiveYouAHead.Help where

--outside
import System.Environment

helpMain ::IO()

helpMain = do
    progName <- getProgName
    putStrLn $ unlines [
        "\tGiveYouAHead\t\t\t version 0.1.1.0 ",
        "\tCommand :",
        "\tCreate a new file ",
        "\t\t"++progName++" new [language] [id] [the list of import]",
        "\tBuild the program(s) ",
        "\t\t"++progName++" build [language]",
        "\t\t"++progName++" build [language] [the list of id] ",
        "\tClean the directory's useless files",
        "\t\t"++progName++" clean",
        "",
        "\tGiveYouAHead\t\t\t版本 0.1.1.0",
        "\t使用帮助",
        "\t命令：",
        "\t创建新文件",
        "\t\t"++progName++" new 【语言】 【id】 【引用列表】",
        "\t构建",
        "\t\t"++progName++" build 【语言】",
        "\t\t"++progName++" build 【语言】 【文件id列表】",
        "\t清理",
        "\t\t"++progName++" clean",
        "",
        "\tHomepage https://github.com/Qinka/GiveYouAHead/",
        "\tBug report: https://github.com/Qinka/GiveYouAHead/issues",
        "\t主页  https://github.com/Qinka/GiveYouAHead/",
        "\tBUG报告  https://github.com/Qinka/GiveYouAHead/issues",
        ""
        ]
