module TestListExtra exposing (suite)

import Expect
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import ListExtra exposing (..)

suite : Test
suite =
  describe "Extra list functions"
    [ describe "pad"
      [ test "pad to same length" <|
          \_ ->
            [1, 2]
              |> ListExtra.pad 2
              |> Expect.equal [Just 1, Just 2]

      , test "pad to shorter length" <|
          \_ ->
            [1, 2]
              |> ListExtra.pad 1
              |> Expect.equal [Just 1, Just 2]

      , test "pad to longer length" <|
          \_ ->
            [1, 2]
              |> ListExtra.pad 3
              |> Expect.equal [Just 1, Just 2, Nothing]
      ]
    ]
