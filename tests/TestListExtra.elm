module TestListExtra exposing (suite)

import Expect
import Test exposing (..)

import ListExtra exposing (..)

suite : Test
suite =
  describe "Extra list functions"
    [ describe "map"
      [ test "map with isEnd flag" <|
        \_ ->
          ListExtra.map (,) [1, 2, 3, 4]
            |> Expect.equal [(1, False), (2, False), (3, False), (4, True)]

      , test "map empty list" <|
        \_ ->
          ListExtra.map (,) []
            |> Expect.equal []
      ]

    -----------------------------------------------------------------
    , describe "pad"
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
    , describe "rightZip"
      [ test "pad equal length lists" <|
          \_ ->
            [1, 2]
              |> ListExtra.rightZip ['a', 'b']
              |> Expect.equal [(Just 'a', 1), (Just 'b', 2)]

      , test "pad left shorter" <|
          \_ ->
            [1, 2]
              |> ListExtra.rightZip ['a']
              |> Expect.equal [(Just 'a', 1), (Nothing, 2)]

      , test "pad right shorter" <|
          \_ ->
            [1]
              |> ListExtra.rightZip ['a', 'b']
              |> Expect.equal [(Just 'a', 1)]
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
