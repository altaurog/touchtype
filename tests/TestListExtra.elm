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

    -----------------------------------------------------------------
    , describe "leftZip"
      [ test "pad equal length lists" <|
          \_ ->
            [1, 2]
              |> ListExtra.leftZip ['a', 'b']
              |> Expect.equal [('a', Just 1), ('b', Just 2)]

      , test "pad left shorter" <|
          \_ ->
            [1, 2]
              |> ListExtra.leftZip ['a']
              |> Expect.equal [('a', Just 1)]

      , test "pad right shorter" <|
          \_ ->
            [1]
              |> ListExtra.leftZip ['a', 'b']
              |> Expect.equal [('a', Just 1), ('b', Nothing)]
      ]

    -----------------------------------------------------------------
    , describe "outerZip"
      [ test "pad equal length lists" <|
          \_ ->
            [1, 2]
              |> ListExtra.outerZip ['a', 'b']
              |> Expect.equal [(Just 'a', Just 1), (Just 'b', Just 2)]

      , test "pad left shorter" <|
          \_ ->
            [1, 2]
              |> ListExtra.outerZip ['a']
              |> Expect.equal [(Just 'a', Just 1), (Nothing, Just 2)]

      , test "pad right shorter" <|
          \_ ->
            [1]
              |> ListExtra.outerZip ['a', 'b']
              |> Expect.equal [(Just 'a', Just 1), (Just 'b', Nothing)]
      ]
    ]
