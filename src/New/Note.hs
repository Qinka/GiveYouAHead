--FP
module New.Note where


addNoteMark :: String       --mk
            -> String       --line
            -> String
makeNotes :: [String]

addNoteMark = (++)
makeNotes = [
    "*noteMarkLine",
    "*COB","\n\n",
    "*COE","\n",
    "*noteMarkLine",
    "\n",
    "*TitleLine","\n",
    "*WriterLine","\n",
    "*timeLine","\n",
    "\tProblem\t:\t","*probId","\n",
    "\n",
    "\tThis file is auto-created by GiveYouAHead.\n",
    "\tGiveYouAHead is a final-alternate of Auto Formwork (mkSource).\n",
    "\tAnd it is writen by Qinka (qinka@live.com) in Haskell.\n",
    "\tVersion of GiveYouAHead : 0.0.1.0 \n",
    "\tYou may can find this on Hackage via Cabal .\n",
    "\t --ps this version may not be push to hackage and  github.\n",
    "*noteMarkLine"]


