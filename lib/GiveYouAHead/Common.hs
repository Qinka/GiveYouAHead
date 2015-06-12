--IO and FP

module GiveYouAHead.Common where


--outside
import System.IO
import System.Directory


getDataDir :: IO FilePath
getDataDir = getAppUserDataDirectory "GiveYouAHead"


getFileMainName :: String -> String
getFileMainName = reverse . dropWhile (/= '.') . reverse
