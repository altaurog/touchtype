module TestTouchType exposing (suite)

import Expect
import Test exposing (..)

import TouchType exposing (..)

suite : Test
suite =
  describe "Touchtype functions"
    [ describe "checkChar"
      [ test "checkChar correct char" <|
          \_ ->
            TouchType.checkChar (Just 'a', 'a')
              |> Expect.equal (Ok 'a')

      , test "checkChar incorrect char" <|
          \_ ->
            TouchType.checkChar (Just 'b', 'a')
              |> Expect.equal (Err 'a')

      , test "checkChar extra char" <|
          \_ ->
            TouchType.checkChar (Nothing, 'a')
              |> Expect.equal (Err 'a')
      ]

    , describe "checkLine"
      [ test "checkLine correct and complete" <|
          \_ ->
            TouchType.checkLine ("The ", Just "The ")
              |> Expect.equal [Ok 'T', Ok 'h', Ok 'e', Ok ' ']

      , test "checkLine correct but incomplete" <|
          \_ ->
            TouchType.checkLine ("The ", Just "Th")
              |> Expect.equal [Ok 'T', Ok 'h']

      , test "checkLine excess" <|
          \_ ->
            TouchType.checkLine ("The ", Just "The q")
              |> Expect.equal [Ok 'T', Ok 'h', Ok 'e', Ok ' ', Err 'q']

      , test "checkLine incorrect but complete" <|
          \_ ->
            TouchType.checkLine ("The ", Just "Tha ")
              |> Expect.equal [Ok 'T', Ok 'h', Err 'a', Ok ' ']

      , test "checkLine incorrect and incomplete" <|
          \_ ->
            TouchType.checkLine ("The ", Just "Tj")
              |> Expect.equal [Ok 'T', Err 'j']

      , test "checkLine empty input" <|
          \_ ->
            TouchType.checkLine ("The ", Nothing)
              |> Expect.equal []
      ]
    ]
