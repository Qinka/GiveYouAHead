{-# LANGUAGE OverloadedStrings #-}

--Fp and Data
--
module Settings.Data  where

--85698218
{-
import Data.Aeson


data Settings = Settings
    {
        usedShell                       :: String,
        defaultFileName                 :: String
    } deriving Show


instance FromJSON Settings where
    parseJSON (Object v)    = Settings <$>
                              v .: "usedShell"<*>
                              v .: "defaultFileName"
    parseJSON _ = error "ERROR!!"

instance ToJSON Settings where
    toJson (Settings
-}

data Setting = Setting
    {
        shell ::String,
        fileName :: String,
        sysShell ::String
    } deriving (Read,Show)

