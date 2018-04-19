module Style exposing (..)

import Css exposing (..)
import Css.Colors
import Html.Styled exposing (Attribute)
import Html.Styled.Attributes exposing (css)

cssAttribute : Style -> Attribute msg
cssAttribute style = css [ style ]

page : Attribute msg
page = cssAttribute <|
  Css.batch
    [ fontFamilies ["Monospace"]
    , fontSize (pt 14)
    , margin (px 0)
    ]

exercise : Attribute msg
exercise = cssAttribute <|
  Css.batch
    [ marginBottom (em 1.5) ]

line : Attribute msg
line = cssAttribute <|
  Css.batch
    [ height (em 1)
    , whiteSpace pre
    ]

cursor : Attribute msg
cursor = cssAttribute <|
  Css.batch
    [ color Css.Colors.green
    , backgroundColor Css.Colors.green
    ]

error : Attribute msg
error = cssAttribute <|
  Css.batch
    [ color Css.Colors.red
    , borderBottom3 (px 1) solid Css.Colors.red
    ]
