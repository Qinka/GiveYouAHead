




module GiveYouAHead.Config
    (
    getDirectory,
    getTemplateDirectory,
    addCommandMap,
    config
    ) where

      import GiveYouAHead.Common(writeF,readF)
      import System.IO(openFile,IOMode(..),hGetLine,hClose,hIsEOF)
      import Data.GiveYouAHead(CommandMap,Switch(..),delcm,turncm,chcm)
      import System.Directory(getDirectoryContents)
      --import Control.DeepSeq(force)

      getTemplateDirectory :: IO String
      getTemplateDirectory = return ".gyah/template"

      getDirectory :: IO String
      getDirectory = return ".gyah"

      addCommandMap :: String -> CommandMap -> IO ()
      addCommandMap fn' cm =
        before fn>>= (after fn.show.(cm++).read)
        where
          (_,fn)=splitAt 17 fn'

      listCommandMap :: IO()
      listCommandMap = do
        getDirectoryContents ".gyah" >>= mapM putCM.filter isCM
        return ()
        where
          isCM :: String -> Bool
          isCM str = let (h,_) = splitAt 10 str in h == "commandmap"

      putCM :: FilePath -> IO ()
      putCM fn = do
        readF (".gyah/"++fn) >>= mapM putStrLn.(++["---"]).(fileHead:).zipWith (curry tT) [0..].read
        return ()
        where
          fileHead =  "\n=========\ncommandmap of "++fn
          tT :: (Int,(Switch,String,String)) -> String
          tT (i,(x,y,z)) = "\n---\n"++"Id:"++show i++"\n"++"Name:\t"++y++"\nStatus:\t"++show x++"\nText:\t"++z

      before :: String -> IO String
      before fn' = do
        h <- openFile (".gyah/commandmap"++(if null fn then fn else '.':fn)) ReadMode
        rt <- getAll h
        hClose h
        return rt
        where
          (_,fn)=splitAt 17 fn'
          getAll handle = do
            bool <- hIsEOF handle
            if bool then return ""
              else do
                new <- hGetLine handle
                other <- getAll handle
                return $ other++new


      after :: String -> String -> IO ()
      after fn'= writeF $ ".gyah/commandmap" ++ if null fn then "" else '.':fn
        where
          (_,fn)=splitAt 17 fn'

      config :: [String] -> IO ()
      config ("addcm":fn:xs) =
        addCommandMap fn $ map (\(x,y)->(On,x,y)) $ toPair xs
      config ("listcm":_) =
        listCommandMap
      config ("delcm":fn':cm) =
        before fn >>= after fn.show.delcm (map read cm).read
        where
          (_,fn)=splitAt 17 fn'
      config ("chcm":fn':i:t:_) =
        before fn >>= after fn.show.chcm (read i) t.read
        where
          (_,fn)=splitAt 17 fn'
      config ("turncm":fn':i:_) =
        before fn >>= after fn.show.turncm (read i).read
        where
          (_,fn)=splitAt 17 fn'

      config _ = undefined

      _ul :: [IO ()] -> IO ()
      _ul _ = return ()

      toPair :: [a] -> [(a,a)]
      toPair [] = []
      toPair [_] = []
      toPair (x:y:s) = (x,y):toPair s
