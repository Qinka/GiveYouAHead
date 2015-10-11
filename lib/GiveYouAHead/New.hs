




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
          -> [Bool]         -- commandmap's, template's
          -> IO ()

      new tp num imp (idscm:idst:_) = do
        template <- getTemplate idst $ "new." ++ if null tp then "default" else tp
        time <- getClockTime
        cm <- getCM idscm
        let cm' = importCM cm:(On,"timeNow",show time):cm
          in writeF (findKey cm "numLeft"++num++findKey cm "numRight") $ concat.toText cm' $ template
        return ()
        where
          importCM cm = (On,"importList",unlines.map ((findKey cm "importLeft" ++).(findKey cm "importRight" ++)) $ imp)
      new _ _ _ _ = undefined
