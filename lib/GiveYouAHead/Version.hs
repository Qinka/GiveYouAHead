




module GiveYouAHead.Version
    (
    version,
    gyahver
    ) where

      import Data.Version


      version :: Version
      version = Version { versionBranch = [0,3,0,24] , versionTags=[]}
      gyahver :: String
      gyahver = showVersion version
