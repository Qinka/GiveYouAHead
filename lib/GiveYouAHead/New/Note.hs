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
<<<<<<< HEAD
    "\tVersion "++ gyahver ++"\n",
=======
    "\tVersion 0.2.2.0\n",
>>>>>>> 5812e13d3569521863a8128c3f7e00a5abd431fb
    "\n",
    "\tHomepage: https://github.com/Qinka/GiveYouAHead\n",
    "\tBug report: https://github.com/Qinka/GiveYouAHead/issues\n",
    "\n",
    "*noteMarkLine","\n"]
