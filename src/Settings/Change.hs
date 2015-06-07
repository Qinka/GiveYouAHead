--IO & FP

module Settings.Change where


--inside
import Common.Data


changeSwitchStatus :: String                --key
                   -> CmdMap                --Command Map
                   -> Int
                   -> CmdMap

changeSwitchStatus key ((s,k,v):xs) id
    | k == key && id == 0 = (turnSwitch s,k,v) : xs
    | k == key && id /= 0 = (s,k,v) : changeSwitchStatus key xs (id-1)
    | otherwise = (s,k,v) : changeSwitchStatus key xs (id-1)
