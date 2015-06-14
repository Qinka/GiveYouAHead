module AConfig where

import Data.GiveYouAHead

import GiveYouAHead.Settings




-- there is the datas ,you can edit it if necessary.

--the data which hold some basic settings
sysSetting :: Settings
sysSetting = Settings
    {
      -- the default shell, which you like
      dfShell = "cmd", --if your os is linux or somethings like unix it may be sh or bash
      --the default part of name which is the code
      dfFileName = "Prob",
      -- the default system shell
      sysShell = "cmd" -- if your os is an unix-like os ,it may be sh
    }


persionCMap :: CommandMap

persionCMap = zip3 ons names values
    where
      ons = repeat On
      -- this you can not change , unless you know how does it work and realy necessary.
      names =["*TitleLine","*WriterLine"]
      --this is the one ,which you have to change
      values = [
          -- *TitleLine the one which will be printed on you code's notes or commits
          -- and you might need a \t at the begin of each line
          "\tSoftware School Programming Trainning",
          -- *WriterLine the one which included some information of you self
          --and it will be printed on you code's notes or commits.
          -- \t might needed
          "\tQinka, Class 1413014\n\temail: qinka@live.com"
        ]
--the basic delete list (of file extension)
baseDelList :: [String]
baseDelList = [
      " " , --nothings
      -- the executable file's extension
      -- if your OS is an unix-like OS, you' need to chose whether you need to have one
      -- and this is useful for clean up somewhere
      "*.exe"
  ]

--cmd's config CommandMap
-- you need change it if your OS　is an unix like OS
cmdShellCMap :: CommandMap
cmdShellCMap = zip3 ons names values
    where
      ons = repeat On
      -- this you'd better not change, unless you know how it works and realy necessary
      names = ["*Del","*DelForce","*DelQuite","*ShellFileBack","*SysShellRun","*MakefileBegin","*MakefileEnd","*ExecutableFE"]
      --this is the one you can change
      values = [
            -- how this shell do delete command
            "del",
            -- the option about force
            "/F",
            --the option about quite
            "/Q",
            -- the file extension of shell's script (with point)
            ".bat",
            --how system's shell run this shell
            -- if this is the system's shell, leave it a spcae
            " ",
            -- what should write down in the makefile's beginning part
            -- example : to show the date and time
            "@echo off\n", --rfemember to add \n
            -- the one at the end of makefile
            "@echo You have to del .makefile.bat youself", -- this means if you want to auto delete .makefile.bat you might add the following : @del .makefile.bat
            -- the file extension of an executable file (without point)
            "exe"
        ]



-- there is the script ,you'd better not to change it unless necessary
