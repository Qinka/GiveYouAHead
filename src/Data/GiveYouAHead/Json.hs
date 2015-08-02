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
{-# LANGUAGE DeriveGeneric #-}
module Data.GiveYouAHead.Json (

) where


import Data.Aeson
import GHC.Generics
import Control.Applicative
import qualified Data.ByteString.Lazy as Bs
import System.Directory

--Global Settings
data GlobalConfig = GlobalConfig{
        systemDefaultShell :: String,
        author::String,
        email::String,
        localizationLang::String
    } deriving Generic
instance FromJSON GlobalConfig
instance ToJSON GlobalConfig

--Project Compiling Settings
data CompileConfig = CompileConfig{
        compiler::String,
        language::String,
        fileExtenson::String
    }deriving Generic
instance FromJSON CompileConfig
instance ToJSON CompileConfig

--Compiler Settings
data CompilerSet = CompilerSet{
        cmd::String,
        object::String,
        debug::String,
        onlyCompile::String
    }deriving Generic
instance FromJSON CompilerSet
instance ToJSON CompilerSet

--MakeFileScript
data MakeFileConfig = MakeFileConfig{
        makefileBegin::String,
        makefileEnd::String,
        fileExtension::String
    }deriving Generic
instance FromJSON MakeFileConfig
instance ToJSON MakeFileConfig

--how to build
data BuildConfig = BuildConfig{
        directBuild::Bool,
        binaryDir::String,
        objectDir::String,
        testDir::String,
        executableFE::String
    }deriving Generic
instance FromJSON BuildConfig
instance ToJSON BuildConfig

--Language Settings
data LanguageConfig = LanguageConfig{
        noteMake::String,
        extraOptB::String,
        extraOptE::String,
        importBeg::String,
        importEnd::String
    }deriving Generic
instance FromJSON LanguageConfig
instance ToJSON LanguageConfig

--Project Setting
data ProjectConfig = ProjectConfig{
        title::String,
        directory::Bool,
        template::String,
        nameL::String,
        nameR::String,
        license::[String],
        licenseFile::[String]
    }deriving Generic
instance FromJSON ProjectConfig
instance ToJSON ProjectConfig

data ShellConfig =ShellConfig{
        removeCmd::String,
        removeForce::String,
        removeQuite::String
    }deriving Generic
instance FromJSON ShellConfig
instance ToJSON ShellConfig

getConfig :: (FromJSON a) => FilePath -> IO (Maybe a)
setConfig :: ToJSON a => a -> FilePath -> IO ()

getConfig path = do
    input <- Bs.readFile path
    let rt = decode input ::FromJSON a =>  Maybe a
    return rt

setConfig x path = do
    Bs.writeFile path $ encode x
    return ()

getGlobalConfig :: IO (Maybe GlobalConfig)
getGlobalConfig = do
    udd <-getAppUserDataDirectory "GiveYouAHead"
    getConfig $udd ++ "/globalconfig.json" ::IO (Maybe GlobalConfig)




writeGlobalConfig :: GlobalConfig -> IO ()
writeGlobalConfig x = do
    udd <- getAppUserDataDirectory "GiveYouAHead"
    setConfig x $ udd++"/globalconfig.json"



