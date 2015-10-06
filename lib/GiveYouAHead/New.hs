




module GiveYouAHead.New
    (
    new
    ) where

      import           GiveYouAHead.Template     (getTemplate,getCM)
      import           Data.GiveYouAHead         (toText,findKey,Switch(..))
      import           System.Time               (getClockTime)
      import           GiveYouAHead.Common       (writeF)

      new :: String         -- Template
          -> String         -- id or num
          -> [String]       -- import list
          -> IO ()

      new tp num imp = do
        template <- getTemplate $ "new." ++ tp
        time <- getClockTime
        cm <- getCM
        let cm' = importCM cm:(On,"timeNow",show time):cm
          in writeF (findKey cm "numLeft"++num++findKey cm "numRight") $ concat.toText cm' $ template
        return ()
        where
          importCM cm = (On,"importList",unlines.map ((findKey cm "importLeft" ++).(findKey cm "importRight" ++)) $ imp)
