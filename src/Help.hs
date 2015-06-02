--IO
module Help where


helpMain ::IO()
helpMain = putStr $
              unlines
                 ["\t", "GvieYouAHead\t\t\t0.1", "preRelease version",
                  "Pretend that there has the document of help", "\t"]
