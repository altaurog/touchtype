module TouchType exposing (..)

{-| Business logic for touchtype app
-}

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
