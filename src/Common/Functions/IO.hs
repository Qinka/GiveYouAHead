--IO
module Common.Functions.IO where
--outside
import System.Directory
--import System.Environment

--inside
import Common.Data


getCmdMap   ::  String          --FileName
            ->  IO CmdMap

getDataDir :: IO FilePath

getCmdMap filename = do
    filetext <- readFile filename
    return (read filetext :: CmdMap )

getDataDir =  getAppUserDataDirectory "GiveYouAHead"
