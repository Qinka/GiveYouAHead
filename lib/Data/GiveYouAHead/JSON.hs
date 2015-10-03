{-# LANGUAGE OverloadedStrings #-}




module Data.GiveYouAHead.JSON
    (
      USettings(..),
      getUSettings
    ) where

      import Data.GiveYouAHead(USettings(..))
      import Data.Aeson(FromJSON(..),ToJSON(..),decode,Value(..),object,(.:),(.=))
      import Control.Applicative()
      import Data.ByteString.Lazy.Char8(pack)

      import  GiveYouAHead.Common(readF)

      instance FromJSON USettings where
        parseJSON (Object v) = USettings
                               <$> (v .: "SystemShell")

      instance ToJSON USettings where
        toJSON (USettings sysSh) =
          object ["SystemShell" .= sysSh]

      getUSettings :: FilePath -> IO (Maybe USettings)
      getUSettings = (>>= return.decode.pack).readF
