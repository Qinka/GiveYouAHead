--IO
module Help where


helpMain ::IO()
helpMain = do
    putStr $ concat $ map (++"\n") [
        "\t",
        --Help
        --
        "GvieYouAHead\t\t\t0.1",
        "preRelease version",
        "Pretend that there has the document of help",
        --
        "\t"
        ]
