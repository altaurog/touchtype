module TestHtmlDisplay exposing (suite)

import Expect
import Test exposing (..)

import Html.Styled exposing (Html, Attribute, div, span, text)
import Html.Styled.Attributes exposing (css)

import HtmlDisplay exposing (..)
import Style

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
              |> Expect.equal (span [] [text "a"])

      , test "convert incorrect char to span" <|
          \_ ->
            HtmlDisplay.checkedSpan (Err 'a')
              |> Expect.equal (span [ css [ Style.error ] ] [text "a"])
      ]

    , describe "lineDiv"
      [ test "convert master/input text to html" <|
          \_ ->
            HtmlDisplay.lineDiv ("I am", Just ("I mm", True))
              |> Expect.equal (div [ css [ Style.exercise ] ] [
                  div [ css [ Style.line ] ] [text "I am"],
                  div [ css [ Style.line ] ] [
                    span [] [text "I"],
                    span [] [text " "],
                    span [ css [ Style.error ] ] [text "m"],
                    span [] [text "m"]
                  ]
                ])
      ]
    ]

