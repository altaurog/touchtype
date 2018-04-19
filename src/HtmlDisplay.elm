module HtmlDisplay exposing (..)

{-| Display logic for touchtype app
-}

import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (css)

import ListExtra
import TouchType exposing (Checked, checkLine)
import Style

{-| Display an exercise
-}

exercise : List String -> List String -> Html msg
exercise master input =
   ListExtra.map (,) input
    |> ListExtra.leftZip master
    |> List.map lineDiv
    |> div [ css [Style.page] ]


{-| Display a master input line pair
-}
lineDiv : (String, Maybe (String, Bool)) -> Html msg
lineDiv (master, inputWithFlag) = 
  div [ css [Style.exercise] ]
  [ div [ css [Style.line] ] [text master]
  , div [ css [Style.line] ] (checkLine master inputWithFlag |> List.map checkedSpan)
  ]


{-| Display a checked input letter
-}

checkedSpan : Checked -> Html msg
checkedSpan checked =
  case checked of
    Ok char -> span [] [charText char]
    Err char -> span [ css [Style.error] ] [charText char]


{-| Convert a char to Html text element
-}

charText : Char -> Html msg
charText c = String.fromList [c] |> text
