module ListExtra exposing (..)


pad : Int -> List a -> List (Maybe a)
pad len xs =
  let
    d = len - List.length xs
    padding = if 0 < d then List.repeat d Nothing else []
  in
    (List.map Just xs) ++ padding
