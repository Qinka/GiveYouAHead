




module GiveYouAHead.Version
    (
    version,
    gyahver
    ) where

      import Data.Version


      version :: Version
      version = Version { versionBranch = [0,2,7,0] , versionTags=[]}
      gyahver :: String
      gyahver = showVersion version
