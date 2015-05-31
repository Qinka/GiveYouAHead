--IO
module Common.Functions.IO where
--import System.IO
import System.Environment

getCmdMap   ::  String          --FileName
            ->  IO [(String,String)]

getProgDir :: IO String

getCmdMap filename = do
    filetext <- readFile filename
    return (read filetext :: [(String,String)])

getProgDir = do
    pn <- getExecutablePath
    return $ gP pn
    where
        gP =   reverse.(dropWhile (\x -> x/= '\\')).reverse
