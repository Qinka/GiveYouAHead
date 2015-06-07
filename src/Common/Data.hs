--Data
module Common.Data where


-- 选项 的开关
data Switch = Off | On deriving (Show , Read , Eq ,Ord)

turnSwitch :: Switch -> Switch
turnSwitch On = Off
turnSwitch Off = On


-- CommandMap
--Switch 表示 该选项是否开启
type CmdMap = [(Switch,String,String)]
