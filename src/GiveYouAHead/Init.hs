-----------------------------------------------------------------------------
--
-- Module      :  GiveYouAHead.Init
-- Copyright   :  2015 (C) Qinka <qinka@live.com>
-- License     :  AllRightsReserved
--
-- Maintainer  :  qinka@live.com
-- Stability   :  GiveYouAHead
--
-----------------------------------------------------------------------------

module GiveYouAHead.Init (

) where

import Data.GiveYouAHead.Json
import System.IO.Extra
import System.Directory


import Localization.GiveYouAHead

createFiles ::IO ()

createFiles = do
    gS <- getGlobalConfig
    case gS of
        Nothing -> error " ERROR CANNOT LOAD GLOBALCONFIG SORRY :( "
        _ -> do
        let (Just gS') = gS
        lang' <- getLangData  $ localizationLang gS'
        let lang = langGet lang'
        isEx <- doesDirectoryExist "./.gyah"
        if isEx then warining lang else nextStep
        return ()
    where
        waring lang = do
            putStrLn $ initLang'fail lang -- 输出 当前目录已被初始化
        nextStep lang =do
            createDirectory "./.gyah"

        langGet Nothing = error " ERROR CANNOT LOAD THE FILE OF LOCALIZATION  SORRY :( "
        langGet (Just x) = x

