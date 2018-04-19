module TestHtmlDisplay exposing (suite)

import Expect
import Test exposing (..)

import Html exposing (Html, Attribute, div, span, text)
import Html.Attributes exposing (class)

import HtmlDisplay exposing (..)

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
            HtmlDisplay.checkedSpan (Ok 'a')
              |> Expect.equal (span [class "ok char"] [text "a"])

      , test "convert incorrect char to span" <|
          \_ ->
            HtmlDisplay.checkedSpan (Err 'a')
              |> Expect.equal (span [class "error char"] [text "a"])
      ]

    , describe "lineDiv"
      [ test "convert master/input text to html" <|
          \_ ->
            HtmlDisplay.lineDiv ("I am", Just ("I mm", True))
              |> Expect.equal (div [] [
                  div [] [text "I am"],
                  div [] [
                    span [class "ok char"] [text "I"],
                    span [class "ok char"] [text " "],
                    span [class "error char"] [text "m"],
                    span [class "ok char"] [text "m"]
                  ]
                ])
      ]
    ]

