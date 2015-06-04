--FP
module New.Note where


addNoteMark :: String       --mk
            -> String       --line
            -> String
makeNotes :: [String]

addNoteMark = (++)
makeNotes = [
    "*noteMarkLine","\n",
    "*COB","\n",
    "\n",
    "*COE","\n",
    "*noteMarkLine","\n",
    " \n",
    "*TitleLine","\n",
    "*WriterLine","\n",
    "*timeLine","\n",
    "\tProblem\t","*probId","\n",
    "\n",
    "\tlicense type: ","*License","\n",
    "\tlicense files: \n",
    "\n",
    "\tThis file is auto-created by GiveYouAHead.\n",
    "\tGiveYouAHead is a final-alternate of Auto Formwork (mkSource).\n",
    "\tAnd it is writen by Qinka (qinka@live.com) in Haskell.\n",
    "\tVersion of GiveYouAHead : preview version 0.1.0.2 \n",
    "\n",
    "\tHomepage: https://github.com/Qinka/GiveYouAHead\n",
    "\tBug report: https://github.com/Qinka/GiveYouAHead/issues \n",
    "\n",
    "\tYou may can find this on Hackage via Cabal .\n",
    "\t  ps this version may not be push to hackage.\n",
    "\n",
    "*noteMarkLine"]


