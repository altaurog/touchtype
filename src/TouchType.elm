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
checkLine : (String, Maybe String) -> List Checked
checkLine (master, input) =
  let
    i = Maybe.withDefault "" input
  in
    ListExtra.rightZip (String.toList master) (String.toList i)
      |> List.map checkChar


{-| Check a (master, input) character pair.
-}
checkChar : (Maybe Char, Char) -> Checked
checkChar pair =
  case pair of
    (Just m, i) -> if i == m then Ok i else Err i
    (Nothing, i) -> Err i


{-| Append a char to last string in input set
-}
appendToLast : Char.KeyCode -> List String -> List String
appendToLast code xs =
  case (code, xs) of
    (13, [head]) -> [head, ""]      -- add line on CR
    (13, []) -> []                  -- ignore CR at beginning
    (c, []) -> [append c ""]
    (c, [head]) -> [append c head]  -- empty tail must take precedence
    (c, head::tail) -> [head] ++ appendToLast c tail


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
    ""
