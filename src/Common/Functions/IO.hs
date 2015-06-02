--IO
module Common.Functions.IO where
import System.Directory
import System.Environment

getCmdMap   ::  String          --FileName
            ->  IO [(String,String)]

getDataDir :: IO FilePath

getCmdMap filename = do
    filetext <- readFile filename
    return (read filetext :: [(String,String)])

getDataDir =  getAppUserDataDirectory "GiveYouAHead"
