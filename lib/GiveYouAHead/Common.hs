




module GiveYouAHead.Common
    (
    getDataDir,
    getDefaultEncoding,
    getFileMainName,
    readF,
    writeF
    ) where
      import System.Directory(getAppUserDataDirectory)
      import System.IO.Extra(writeFileUTF8,readFileUTF8)


      getDataDir ::IO FilePath
      getDataDir = getAppUserDataDirectory "GiveYouAHead"

      getFileMainName ::String ->String
      getFileMainName = reverse. dropWhile (/= '.') .reverse

      getDefaultEncoding ::IO String
      getDefaultEncoding = getDataDir >>= (readFile . (++"/defaultencoding"))

      readF :: FilePath -> IO String
      readF p= getDefaultEncoding >>= step p
          where
            step :: String -> String -> IO String
            step pp e= case e of
              "UTF8" -> readFileUTF8 pp
              _ -> readFile pp

      writeF :: FilePath -> String -> IO()
      writeF p t = getDefaultEncoding >>=
        (\pp tt e-> case e of
            "UTF8" -> writeFileUTF8 pp tt
            _ -> writeFile pp tt
          ) p t
