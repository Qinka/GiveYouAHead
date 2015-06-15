module GYAHConfig where

import Data.GiveYouAHead

import GiveYouAHead.Settings
import GiveYouAHead.Common


import System.Directory
import System.Environment

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
      -- this you'd better not to change, unless you know how it works and realy necessary
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
--the commandmap of C language (without compiler)
langCCMap :: CommandMap
langCCMap = zip3 ons names values
    where
        ons = repeat On
        -- this you'd better not to change, unless you know how it works and realy necessary
        names = ["*DefaultCompiler","*Template","*NoteMark","*SrcAhead","*SrcBack","*EOB","*EOE","*ImportAhead","*ImportBack","*FE"]
        --this is the one you can change, but you'd better not.
        values = [
                --the default compiler of C, here, is GCC -- Gnu C Compiler
                --there will be another file of compiler's commandmap
                "gcc",--just how system's shell call it
                -- the one template of C , with a function-main which will return 0
                "\nint main(int argc,char* argv)\n{\n        return 0;\n}\n",
                -- the note mark of C (!! line-note mark)
                "//",
                -- the head of C
                -- it makes file's name like : C_Probxx.C
                -- you can change it to an empty string
                "C_",
                -- the file's extension (with point)
                -- but it not only a FE, but also can make file's name like C_Probxx_Qinka.C
                ".c", -- for that example : "_Qinka.c"
                -- the beginning mark of extra-options
                -- this part will have an wiki
                "ExtraOptionsBegin",
                -- the end
                "ExtraOptionsEnd",
                -- if the language needs to import some librarys or somethings like that
                -- for C language it is #include<head-file>
                --the front part
                "#include<",
                --the behind part
                ">\n", -- the \n is necessary, unless the language's import does not have to breaklines
                -- just only the file's extension (without point/dot)
                "c"
            ]

-- a commandmap of Gnu C Compiler
-- MinGW's gcc and TDM-GCC both ok
-- my gcc is the one that is accessary with Glasgow Haskell Compilation
compilerGCCCMap :: CommandMap
compilerGCCCMap = zip3 ons names values
    where
      ons = repeat On
      -- this is the one you'd better not to change
      names = ["*Compiler","*Debug","*Object"]
      -- this is the one you can change, if necessary
      values = [
            -- just the way how system shell call compiler
            "gcc",
            -- tell the compiler that you want to debug this
            "-g",
            -- how the compiler place the output file
            "-o"
            -- if  you want to use -O2 or sometings like that
            -- you need to add it into extra-options
        ]
-- the commandmap of Haskell
langHaskellCMap :: CommandMap
langHaskellCMap = zip3 ons names values
    where
      ons = repeat On
      -- this you'd better not to change, unless you know how it works and realy necessary
      names = ["*DefaultCompiler","*Template","*NoteMark","*SrcAhead","*SrcBack","*EOB","*EOE","*ImportAhead","*ImportBack","*FE"]
      --this is the one you can change, but you'd better not.
      values = [
              --the default compiler of Haskell, here, is GHC -- Glasgow Haskell Compilation
              --there will be another file of compiler's commandmap
              "ghc",--just how system's shell call it
              -- the one template of Haskell , with a function-main which will do nothing
              "\nmain :: IO ()\nmain = return ()\n",
              -- the note mark of Haskell (!! line-note mark)
              "--",
              -- the head of Haskell
              -- it makes file's name like : Haskell_Probxx.hs
              -- you can change it to an empty string
              "Haskell_",
              -- the file's extension (with point)
              -- but it not only a FE, but also can make file's name like Haskell_Probxx_Qinka.hs
              ".hs", -- for that example : "_Qinka.hs"
              -- the beginning mark of extra-options
              -- this part will have an wiki
              "ExtraOptionsBegin",
              -- the end
              "ExtraOptionsEnd",
              -- if the language needs to import some librarys or somethings like that
              -- for Haskell it is : import Module-Name
              --the front part
              "import ", --here needs a spcae
              --the behind part
              "\n", -- the \n is necessary, unless the language's import does not have to breaklines
              -- just only the file's extension (without point/dot)
              "hs"
          ]
-- the commandmap of compiler of Haskell - GHC
compilerGHCCMap :: CommandMap
compilerGHCCMap = zip3 ons names values
  where
    ons = repeat On
    -- this is the one you'd better not to change
    names = ["*Compiler","*Debug","*Object"]
    -- this is the one you can change, if necessary
    values = [
          -- just the way how system shell call compiler
          "ghc",
          -- tell the compiler that you want to debug this
          -- for Haskell you'd better to use ghci (Glasgow Haskell Compilation Interaction)
          -- and i am not the developer of ghc or ghci so don't ask me how to debug!
          " ",
          -- how the compiler place the output file
          "-o"
          -- if  you want to use -O2 or sometings like that
          -- you need to add it into extra-options
      ]

-- the delete list of C
dlCList :: [String]
--you'd better not to change it, unless your compiler has something difference
dlCList = [
      -- the object files, which might are created by compiler
      "*.o" ,
      -- someone's vim will create a backup file, and I am the one ~_~
      "*.c~"
  ]
dlHaskellList :: [String]
--you'd better not to change it, unless your Haskell compiler isn't GHC
dlHaskellList = [
      -- the object files, which might are created by compiler
      "*.o",
      -- the file created by ghc
      "*.hi",
      -- vim's backup
      "*.hs~"
  ]
dlCmdList :: [String]
dlCmdList = ["*.bat"]
createDir :: IO()
createDir = do
  gDD <- getDataDir
  iE <- doesDirectoryExist gDD
  if iE then do
      putStrLn "uad exist"
    else do
      createDirectory gDD
  iE <- doesDirectoryExist $ gDD ++ "/shell"
  if iE then do
      putStrLn "shell's directory exist"
    else do
      createDirectory $ gDD ++ "/shell"
  writeFile (gDD ++ "/delList.dat") (show ([]::[String]))
  iE <- doesDirectoryExist $ gDD ++ "/compiler"
  if iE then do
      putStrLn "compiler's directory exist"
    else do
      createDirectory $ gDD ++ "/compiler"
  iE <- doesDirectoryExist $ gDD ++ "/language"
  if iE then do
      putStrLn "comopiler's directory exist"
    else do
      createDirectory $ gDD ++ "/language"
  return ()
-- there is the script ,you'd better not to change it unless necessary

--IO
-- write the datas to files
configureFromThisFile :: IO()
configureFromThisFile = do
  putStrLn "NOTE:: you might have to change something in this file"
  putStrLn "\tbefore you configure this, make sure you have changed it"
  putStrLn "if you are sure, then type yes. if not, type no"
  yn <- getLine
  if yn == "yes"
    then do
      -- the list to be done
      -- if you don't want to do one of those, just add note/commit marks,
      --

      -- configure personCMap
      writeDataFrom "person.cmap" persionCMap

      -- configure basic delete list
      dropDelListRepeatedAndAdd baseDelList

      -- configure basic setting
      writeDataFrom "settings.dat" sysSetting

      -- configure C language
      writeDataFrom "language/c.cmap" langCCMap
      -- configure C's compiler : Gnu C Compiler
      writeDataFrom "compiler/gcc.cmap" compilerGCCCMap
      -- configure C's delete list
      dropDelListRepeatedAndAdd dlCList

      -- configure Haskell
      writeDataFrom "language/Haskell.cmap" langHaskellCMap
      -- configure Haskell's compiler Glasgow Haskell Compilation
      writeDataFrom "compiler/ghc.cmap" compilerGHCCMap
      -- configure Haskell's delete list
      dropDelListRepeatedAndAdd dlHaskellList

      -- configure shell => cmd , the system-shell of MS-WindowsNT (my Windows, now, are both Windows 8.1 with Bing, my pad, and Windows 10 Insider Preview Pro, my laptop)
      -- DO NOT ask me why I do not use PowerShell, though I am a PowerShell user
      -- somethings in above might be MS's "icon" , English is pool =_=||
      writeDataFrom "shell/cmd.cmap" cmdShellCMap

      -- add cmd's delete list
      dropDelListRepeatedAndAdd dlCmdList
      putStrLn "finish , aha!"

    else
      return ()
      --close!
  return ()
