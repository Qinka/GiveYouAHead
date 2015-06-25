--FP
module GiveYouAHead.New.Note where

import GiveYouAHead.Version


addNoteMark ::  String --mk
            ->  String --lines
            ->  String

makeNotes :: [String]

addNoteMark = (++)

makeNotes = [
    "*noteMarkLine","\n",
    "*EOB","\n",
    "\n",
    "*EOE","\n",
    "*noteMarkLine","\n",
    "\n",
    "*TitleLine","\n",
    "*WriterLine","\n",
    "*timeLine","\n",
    "\tProblem\t","*probId","\n",
    "\n",
    "\tlicense type: ","*License","\n",
    "\tlicense file: \n",
    "\n",
    "\tThis file is auto--created by GiveYouAHead.\n",
    "\tGiveYouAHead is written by Qinka (qinka@live.com) in Haskell.\n",
    "\tVersion "++ gyahver ++"\n",
    "\n",
    "\tHomepage: https://github.com/Qinka/GiveYouAHead\n",
    "\tBug report: https://github.com/Qinka/GiveYouAHead/issues\n",
    "\tHackage(Module): http://hackage.haskell.org/package/GiveYouAHead\n",
    "\tHackage(Binary): http://hackage.haskell.org/package/gyah-bin\n",
    "\n",
    "*noteMarkLine","\n"]
