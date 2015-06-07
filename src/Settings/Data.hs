--{-# LANGUAGE OverloadedStrings #-}

--Fp and Data
--
module Settings.Data  where


--remember to replace the one in Setup.hs when this change
data Setting = Setting
    {
        shell ::String,
        fileName :: String,
        sysShell ::String
    } deriving (Read,Show)
