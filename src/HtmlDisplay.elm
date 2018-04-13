module HtmlDisplay exposing (..)

{-| Display logic for touchtype app
-}

import Html exposing (Html, Attribute, div, span, text)
import Html.Attributes exposing (class)

import ListExtra
import TouchType exposing (Checked, checkLine)

{-| Display an exercise
-}

exercise : List String -> List String -> Html msg
exercise master input =
  ListExtra.leftZip master input
    |> List.map lineDiv
    |> div [class "exercise"]


{-| Display a master input line pair
-}
lineDiv : (String, Maybe String) -> Html msg
lineDiv (master, input) = div [] [
    div [] [text master],
    div [] (checkLine master input |> List.map checkedSpan)
  ]


{-| Display a checked input letter
-}

checkedSpan : Checked -> Html msg
checkedSpan checked =
  case checked of
    Ok char -> span [class "ok char"] [charText char]
    Err char -> span [class "error char"] [charText char]


{-| Convert a char to Html text element
-}

charText : Char -> Html msg
charText c = String.fromList [c] |> text
