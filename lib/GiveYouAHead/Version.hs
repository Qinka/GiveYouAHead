--FP Data and IO


module GiveYouAHead.Version where

import Data.Version

gyah'ver :: Version
gyah'ver = Version { versionBranch = [0,2,2,1] , versionTags=[]}
gyahver :: String
gyahver = showVersion gyah'ver
