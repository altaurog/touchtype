module TestHtmlDisplay exposing (suite)

import Expect
import Test exposing (..)

import Html.Styled exposing (Html, Attribute, div, span, text)

import HtmlDisplay exposing (..)
import Style
import TouchType exposing (CheckedVal(..))

suite : Test
suite =
  describe "HTML Display functions"
    [ describe "charText"
      [ test "convert char to HTML text element" <|
          \_ ->
            HtmlDisplay.charText 'a'
              |> Expect.equal (text "a")
      ]

    , describe "checkedSpan"
      [ test "convert correct char to span" <|
          \_ ->
            HtmlDisplay.checkedSpan (Good 'a')
              |> Expect.equal (span [] [text "a"])

      , test "convert incorrect char to span" <|
          \_ ->
            HtmlDisplay.checkedSpan (Bad 'a')
              |> Expect.equal (span [Style.error] [text "a"])
      ]

    , describe "lineDiv"
      [ test "convert master/input text to html" <|
          \_ ->
            HtmlDisplay.lineDiv ("I am", Just ("I mm", True))
              |> Expect.equal (div [Style.exercise] [
                  div [Style.line] [text "I am"],
                  div [Style.line] [
                    span [] [text "I"],
                    span [] [text " "],
                    span [Style.error] [text "m"],
                    span [] [text "m"]
                  ]
                ])
      ]
    ]

