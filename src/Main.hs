




module Main
    (
    main
    ) where


      import Prelude hiding (init)
      import Parameter(getOpt,toPm,argsToString,getFlag)

      import System.Environment(getArgs)
      import System.Directory(setCurrentDirectory)
      import Control.Monad()

      import GiveYouAHead.Help(helpInfo)
      import GiveYouAHead.Init(init)
      import GiveYouAHead.New(new)
      import GiveYouAHead.Build(build)
      import GiveYouAHead.Clean(clean)
      import GiveYouAHead.Config()

      main :: IO ()

      main = do
        putStrLn "GiveYouAHead"
        getArgs >>= (\args->
            case args of
              ("init":_) -> initItem
              ("build":_) -> buildItem
              ("clean":_) -> cleanItem
              ("config":_) -> configItem
              ("new":_) -> newItem
              _ -> helpInfo
          )
        return ()

      initItem,buildItem,cleanItem,newItem,configItem :: IO ()

      changeDir :: [String] -> IO ()
      changeDir (path:_) = setCurrentDirectory path
      changeDir [] = return ()
{-
      getSwitch :: String -> [String] -> [String]
      getSwitch _ [] = []
      getSwitch a (x:xs) = case length x of
        1 -> if x == '-':a then [head xs] else getSwitch a xs
        _ -> if x == "--"++a then [head xs] else getSwitch a xs
-}



      newItem = do
        args' <- getArgs
        let args = toPm $ tail args'
        changeDir $ getOpt args "d"
        let tp = head $ getOpt args "t" ++[""]
        let text = argsToString args
        new tp (head text) (tail text) (map (getFlag args) ["fullc","fullt"])



      initItem = do
        getArgs >>= (changeDir.tail)
        init

      buildItem = do
        ("build":args') <- getArgs
        let args = toPm args'
        changeDir $ getOpt args "d"
        let tp = head $ getOpt args "t" ++ [""]
        build tp (argsToString args) (map (getFlag args) ["fullc","fullt"])

      cleanItem = do
        ("clean":args') <- getArgs
        let args = toPm $ tail args'
        getArgs >>= (\x -> changeDir $ getOpt x "t").toPm.tail
        clean (map (getFlag args) ["fullc","fullt"])

      configItem = undefined
