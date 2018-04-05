module ListExtra exposing (..)


leftZip : List a -> List b -> List (a, Maybe b)
leftZip xs =
  pad (List.length xs)
    >> zip xs


outerZip : List a -> List b -> List (Maybe a, Maybe b)
outerZip xs ys =
  let
    l = max (List.length xs) (List.length ys)
  in
    zip (pad l xs) (pad l ys)


pad : Int -> List a -> List (Maybe a)
pad len xs =
  let
    d = len - List.length xs
    padding = if 0 < d then List.repeat d Nothing else []
  in
    (List.map Just xs) ++ padding


zip : List a -> List b -> List (a, b)
zip = List.map2 (,)
