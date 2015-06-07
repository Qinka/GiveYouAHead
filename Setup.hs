import Distribution.Simple
import System.Directory
import System.Environment


data Setting = Setting
    {
        shell ::String,
        fileName :: String,
        sysShell ::String
    } deriving (Read,Show)




main = do
    (x:_) <- getArgs
    print x
    let y = False
    if x == "build" then do
        putStrLn "is create data?"
        y <- readLn :: IO Bool
        putStrLn ""
        if x == "build" && y then do
                dir <- getAppUserDataDirectory "GiveYouAHead"
                isE <- doesDirectoryExist dir
                if isE then putStrLn "" else createDirectory dir
                isE <- doesDirectoryExist (dir++"/data")
                if isE then putStrLn "" else createDirectory (dir++"/data")
                isE <- doesFileExist (dir ++ "/data/delList.dat")
                if isE then putStrLn "" else writeFile  (dir ++ "/data/delList.dat") (show ([" "]::[String]))
                putStrLn "Input you project common title (by String's String)"
                tl <- readLn ::IO String
                putStrLn "Input you personal coding informations"
                wi <- readLn ::IO String
                putStrLn "Input you default shell"
                sh <- getLine
                putStrLn "Input you common filename"
                fn <- getLine
                putStrLn "Input you SYSTEM's default shell"
                ss <- getLine
                let personM = [("*TitleLine",tl),("*WriterLine",wi)] in
                    do
                        writeFile (dir ++ "/data/person.cmap") (show personM)
                        writeFile (dir ++ "/data/setting.dat") (show (Setting sh fn ss))
                defaultMain
            else defaultMain
       else do
            let y = False
            defaultMain
