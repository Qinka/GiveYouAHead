-----------------------------------------------------------------------------
--
-- Module      :  Data.GiveYouAHead.Json
-- Copyright   :  2015 (C) Qinka <qinka@live.com>
-- License     :  AllRightsReserved
--
-- Maintainer  :  qinka@live.com
-- Stability   :  GiveYouAHead
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

module Data.GiveYouAHead.Json (

) where


import Data.Aeson
import Control.Applicative
import qualified Data.ByteString.Lazy as Bs
import System.Directory


data GlobalConfig =
    GlobalConfig{
        systemDefaultShell :: String
    }

instance FromJSON GlobalConfig where
    parseJSON   (Object v) = GlobalConfig
                             <$> (v .: "systemDefaultShell")


getGlobalConfig :: IO Maybe GlobalConfig
getGlobalConfig = do
    udd <- getAppUserDataDirectory
    input <-Bs.readFile $ udd ++ "/.gyah/globalconfig.json"
    let mm = decode input :: Maybe GlobalConfig
    case mm of
        Nothing -> return Nothing
        Just x -> return Just x

instance ToJSON GlobalConfig where
    toJSON gc = object ["systemDefaultShell" .= (systemDefaultShell gc)]

writeGlobalConfig :: GlobalConfig -> IO ()
writeGlobalConfig x = do
    udd <- getAppUserDataDirectory
    Bs.writeFile $ encode x
    return ()



