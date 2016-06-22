import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Components.Navbar exposing (navbar)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model = {}

init : (Model, Cmd Msg)
init =
  (Model, Cmd.none)

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- UPDATE

type Msg = Foo

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Foo ->
      (model, Cmd.none)


view : Model -> Html Msg
view model =
  div []
    [ navbar
    ]
