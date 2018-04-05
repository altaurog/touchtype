module ListExtra exposing (..)


leftZip : List a -> List b -> List (a, Maybe b)
leftZip xs ys =
  pad (List.length xs) ys
    |> List.map2 (,) xs


pad : Int -> List a -> List (Maybe a)
pad len xs =
  let
    d = len - List.length xs
    padding = if 0 < d then List.repeat d Nothing else []
  in
    (List.map Just xs) ++ padding
