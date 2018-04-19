module Style exposing (..)

import Css exposing (..)
import Css.Colors


page : Style
page = 
  Css.batch
    [ fontFamilies ["Monospace"]
    , fontSize (pt 14)
    , margin (px 0)
    ]

exercise : Style
exercise = Css.batch [ marginBottom (em 1.5) ]

line : Style
line =
  Css.batch
    [ height (em 1)
    , whiteSpace pre
    ]

error : Style
error =
  Css.batch
    [ color Css.Colors.red
    , borderBottom3 (px 1) solid Css.Colors.red
    ]
