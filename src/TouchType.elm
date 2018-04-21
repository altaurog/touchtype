module TouchType exposing (..)

{-| Business logic for touchtype app
-}

import Char

import ListExtra


{-| A checked input is either ok or erroneous.
We reappropriate `Result` for this purpose;
Ok and Err values are both the input character.
-}
type alias Checked = Result Char Char


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
    ListExtra.Both m i -> if i == m then Ok i else Err i
    ListExtra.Right i -> Err i
    ListExtra.Left m -> if isLast then Ok ' ' else Err ' '


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

