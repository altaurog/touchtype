module ListExtra exposing (..)

type OuterZipItem a b = Left a | Right b | Both a b
type alias OuterZipResult a b = List (OuterZipItem a b)


map : (a -> Bool -> b) -> List a -> List b
map f xs =
  case xs of
    [hd] -> [f hd True]
    hd::tl -> [f hd False] ++ map f tl
    [] -> []


leftZip : List a -> List b -> List (a, Maybe b)
leftZip xs =
  pad (List.length xs)
    >> zip xs


rightZip : List a -> List b -> List (Maybe a, b)
rightZip xs ys =
  pad (List.length ys) xs
    |> (flip zip) ys


outerZip : List a -> List b -> OuterZipResult a b
outerZip xs ys =
  case (xs, ys) of
    (x::xtl, y::ytl) -> (Both x y)::(outerZip xtl ytl)
    (x::xtl, []) -> (Left x)::(outerZip xtl [])
    ([], y::ytl) -> (Right y)::(outerZip [] ytl)
    _ -> []


pad : Int -> List a -> List (Maybe a)
pad len xs =
  let
    d = len - List.length xs
    padding = if 0 < d then List.repeat d Nothing else []
  in
    (List.map Just xs) ++ padding


zip : List a -> List b -> List (a, b)
zip = List.map2 (,)
