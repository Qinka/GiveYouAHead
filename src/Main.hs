




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
      import GiveYouAHead.Config(config)

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




      newItem = do
        args' <- getArgs
        let args = toPm $ tail args'
        changeDir $ getOpt args "d"
        let tp = head $ getOpt args "t" ++[""]
        let text = argsToString args
        new tp (head text) (tail text)



      initItem = do
        getArgs >>= (changeDir.tail)
        init

      buildItem = do
        ("build":args') <- getArgs
        let args = toPm args'
        changeDir $ getOpt args "d"
        let tp = head $ getOpt args "t" ++ [""]
        build tp (argsToString args)

      cleanItem = do
        ("clean":args') <- getArgs
        let args = toPm $ tail args'
        getArgs >>= (\x -> changeDir $ getOpt x "t").toPm.tail
        clean

      configItem = undefined
