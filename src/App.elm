import Char
import Html.Styled
import Keyboard

import HtmlDisplay
import TouchType


main =
  Html.Styled.program
    { init = init
    , subscriptions = subscriptions
    , update = update
    , view = view
    }


-- MODEL

type alias Model =
  { master : List String
  , input : String
  }

init : (Model, Cmd Msg)
init =
  ( { master =
      [ "The quick red fox"
      , "jumped over the"
      , "lazy brown dog"
      ]
    , input = ""
    }
  , Cmd.none
  )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Keyboard.presses Presses


-- UPDATE

type Msg = Presses Keyboard.KeyCode

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Presses code ->
      ( { model | input = TouchType.append code model.input }
      , Cmd.none
      )


-- VIEW

view : Model -> Html.Styled.Html Msg
view model =
  HtmlDisplay.exercise model.master model.input
