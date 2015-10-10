-----------------------------------------------------------------------------
--
-- Module      :  Main
-- Copyright   :  Main.hs
-- License     :  AllRightsReserved
--
-- Maintainer  :
-- Stability   :
-- Portability :
--
-- |
--
-----------------------------------------------------------------------------

module Main (
    main
) where

import Test.DocTest

main = doctest ["-isrc", "src/Main.hs"]


