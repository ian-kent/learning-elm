import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Http
import Task
import Json.Decode as Json
import String exposing (length)
import Time exposing (Time, second)

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { topic : String
  , gifUrl : String
  , error : String
  , paused : Bool
  , remain : Int
  }

init : (Model, Cmd Msg)
init =
  (Model "cats" "waiting.gif" "" False 5000, getRandomGif "cats")

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  if model.paused then
    Sub.none
  else
    Time.every (1 * second) Tick

-- UPDATE

type Msg = MorePlease
         | FetchSucceed String
         | FetchFail Http.Error
         | UpdateTopic String
         | Tick Time
         | PauseResume
         | NextImage

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)

decodeGifUrl : Json.Decoder String
decodeGifUrl =
  Json.at ["data", "image_url"] Json.string

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      update NextImage {model | remain = 5000}

    NextImage ->
      ({model | gifUrl = "waiting.gif" }, getRandomGif model.topic)

    FetchSucceed newUrl ->
      ({ model | gifUrl = newUrl }, Cmd.none)

    FetchFail err ->
      ({model | error = case err of
        Http.NetworkError        -> "Network error"
        Http.Timeout             -> "Timeout"
        Http.BadResponse _ _     -> "Bad response"
        Http.UnexpectedPayload _ -> "Unexpected payload"
      }, Cmd.none)

    UpdateTopic topic ->
      update MorePlease { model | topic = topic }

    PauseResume ->
      ({ model | paused = not model.paused }, Cmd.none)

    Tick _ ->
      if model.remain <= 0 then
        update NextImage {model | remain = 5000}
      else
        ({model | remain = model.remain - 1000}, Cmd.none)


-- VIEW

getError : Model -> Html Msg
getError model =
  if String.length model.error > 0 then
    div [] [ text model.error ]
  else
    text ""

view : Model -> Html Msg
view model =
  div []
    [ getError model
    , div [] [
      select [ onInput UpdateTopic ]
        [ option [ value "cats" ] [ text "cats" ]
        , option [ value "dogs" ] [ text "dogs" ]
        ]
      ]
    , img [src model.gifUrl] []
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , button [ onClick PauseResume ] [ if model.paused then text "Resume" else text "Pause" ]
    ]
