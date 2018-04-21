module TestTouchType exposing (suite)

import Expect
import Test exposing (..)

import ListExtra exposing (..)
import TouchType exposing (..)

suite : Test
suite =
  describe "Touchtype functions"
    [ describe "checkChar"
      [ test "checkChar correct char" <|
          \_ ->
             Both 'a' 'a'
              |> TouchType.checkChar True
              |> Expect.equal (Ok 'a')

      , test "checkChar incorrect char" <|
          \_ ->
            Both 'b' 'a'
              |> TouchType.checkChar False
              |> Expect.equal (Err 'a')

      , test "checkChar extra char" <|
          \_ ->
            Right 'a'
              |> TouchType.checkChar True
              |> Expect.equal (Err 'a')

      , test "checkChar missing char not last line" <|
          \_ ->
            Left 'x'
              |> TouchType.checkChar False
              |> Expect.equal (Err ' ')

      , test "checkChar missing char last line" <|
          \_ ->
            Left 'x'
              |> TouchType.checkChar True
              |> Expect.equal (Ok ' ')
      ]

    , describe "checkLine"
      [ test "checkLine correct and complete last line" <|
          \_ ->
            Just ("The ", True)
              |> TouchType.checkLine "The "
              |> Expect.equal [Ok 'T', Ok 'h', Ok 'e', Ok ' ']

      , test "checkLine correct but incomplete last line" <|
          \_ ->
            Just ("Th", True)
              |> TouchType.checkLine "The "
              |> Expect.equal [Ok 'T', Ok 'h', Ok ' ', Ok ' ']

      , test "checkLine excess last line" <|
          \_ ->
            Just ("The q", True)
              |> TouchType.checkLine "The "
              |> Expect.equal [Ok 'T', Ok 'h', Ok 'e', Ok ' ', Err 'q']

      , test "checkLine incorrect but complete last line" <|
          \_ ->
            Just ("Tha ", True)
              |> TouchType.checkLine "The "
              |> Expect.equal [Ok 'T', Ok 'h', Err 'a', Ok ' ']

      , test "checkLine incorrect and incomplete last line" <|
          \_ ->
            Just ("Tj", True)
              |> TouchType.checkLine "The "
              |> Expect.equal [Ok 'T', Err 'j', Ok ' ', Ok ' ']

      , test "checkLine correct but incomplete not-last line" <|
          \_ ->
            Just ("Th", False)
              |> TouchType.checkLine "The "
              |> Expect.equal [Ok 'T', Ok 'h', Err ' ', Err ' ']

      , test "checkLine no input" <|
          \_ ->
            TouchType.checkLine "The " Nothing
              |> Expect.equal []
      ]

    , test "append" <|
        \_ ->
          TouchType.append 113 "The "
            |> Expect.equal "The q"

    , describe "codeToString"
      [ test "printable char" <|
          \_ ->
            TouchType.codeToString 113
              |> Expect.equal "q"

      , test "nonprintable char" <|
          \_ ->
            TouchType.codeToString 9
              |> Expect.equal ""
      ]
    ]
