module TouchType exposing (..)

{-| Business logic for touchtype app
-}

import Char

import ListExtra exposing (OuterZipItem(..))


{-| A checked input is either ok or erroneous.
-}
type CheckedVal a = Good a | Bad a | Missing
type alias Checked = CheckedVal Char


{-| Check a line of input against its master
-}
checkLine : String -> Maybe (String, Bool) -> List Checked
checkLine master inputWithFlag =
  case inputWithFlag of
    Nothing -> []
    Just (input, isLast) ->
      ListExtra.outerZip (String.toList master) (String.toList input)
        |> List.map (checkChar isLast)


{-| Check a (master, input) character pair.
-}
checkChar : Bool -> ListExtra.OuterZipItem Char Char -> Checked
checkChar isLast pair =
  case pair of
    Both m i -> if i == m then Good i else Bad i
    Right i -> Bad i
    Left m -> if isLast then Good ' ' else Missing


{-| Append char to a string
-}
append : Char.KeyCode -> String -> String
append c s = s ++ codeToString c


{-| Convert key code to string
-}
codeToString : Char.KeyCode -> String
codeToString code =
  if 31 < code && code < 127 then
    Char.fromCode code |> String.fromChar
  else
    if 13 == code then "\n" else ""

