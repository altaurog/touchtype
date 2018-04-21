module HtmlDisplay exposing (..)

{-| Display logic for touchtype app
-}

import Html.Styled exposing (..)

import ListExtra
import TouchType exposing (Checked, checkLine)
import Style

{-| Display an exercise
-}

exercise : List String -> String -> Html msg
exercise master input =
  String.lines (input ++ "\0") 
    |> ListExtra.map (,)
    |> ListExtra.leftZip master
    |> List.map lineDiv
    |> div [Style.page]


{-| Display a master input line pair
-}
lineDiv : (String, Maybe (String, Bool)) -> Html msg
lineDiv (master, inputWithFlag) = 
  div [Style.exercise]
  [ div [Style.line] [text master]
  , div [Style.line] (checkLine master inputWithFlag |> List.map checkedSpan)
  ]


{-| Display a checked input letter
-}

checkedSpan : Checked -> Html msg
checkedSpan checked =
  case checked of
    Err '\0' -> span [Style.cursor] [text " "]
    Ok char -> span [] [charText char]
    Err char -> span [Style.error] [charText char]


{-| Convert a char to Html text element
-}

charText : Char -> Html msg
charText c = String.fromChar c |> text
