--IO and FP

module GiveYouAHead.Common where


--outside
--import System.IO
import System.Directory
import System.IO.Extra

getDataDir :: IO FilePath
getDataDir = getAppUserDataDirectory "GiveYouAHead"


getFileMainName :: String -> String
getFileMainName = reverse . dropWhile (/= '.') . reverse

getDefaultEncoding :: IO String

getDefaultEncoding = do
  gDD <- getDataDir
  ec <- readFile $ gDD ++ "/defaultencoding"
  return ec

readF :: FilePath -> IO String
readF fpath = do
  ec <- getDefaultEncoding
  case ec of
    "UTF8" -> readFileUTF8 fpath
    _ -> readFile fpath
writeF fpath str = do
  ec <- getDefaultEncoding
  case ec of
    "UTF8" -> writeFileUTF8 fpath str
    _ ->writeFile fpath str


writeF :: FilePath -> String  -> IO()
