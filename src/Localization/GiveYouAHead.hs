-----------------------------------------------------------------------------
--
-- Module      :  Localization.GiveYouAHead
-- Copyright   :  2015 (C) Qinka <qinka@live.com>
-- License     :  AllRightsReserved
--
-- Maintainer  :  qinka@live.com
-- Stability   :  GiveYouAHead
--
-----------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

import Data.Aeson
import GHC.Generics
import Control.Applicative
import qualified Data.ByteString.Lazy as Bs
import System.Directory

module Localization.GiveYouAHead (

) where

getLangData ::  String                              -- ÓïÖÖ
            ->  IO (Maybe Lang)
isLangRight  ::  String                              -- ÓïÖÖ
            ->  IO Bool

listLangUseful  ::  IO  [String]

isLangRight langName = do
    udd <-getAppUserDataDirectory "GiveYouAHead"
    langSource <- Bs.readFile $ udd ++ "/language/"++langName++".json"
    let x = decode langSource :: Maybe Lang
    case x of
        Nothing -> return False
        _ ->       retunr True

getLangData langName =do
    udd <- getAppUserDataDirectory "GiveYouAHead"
    langSource <- Bs.readFile $ udd ++ "/language"++langName++".json"
    let x = decode langSource ::Maybe Lang
    return x


listLangUseful = do
    udd <- getAppUserDataDirectory "GiveYouAHead¡°
    list <- getDirectoryContents $ udd ++ "/lang"
    isThis lis
    where
        isThis [] = return []
        isThis (x:xs) = do
            i <- isOk x
            if i then do
                    tmp <- isThis xs
                    return (x:tmp)
                else
                    isThis xs


data Lang = Lang {
        initLang'fail :: LangInit,
    } deriving Generic


data LangInit = LangInit{
        alreadyInit ::String,
    } deriving Generic


