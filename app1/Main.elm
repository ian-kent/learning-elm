import Html exposing (..)
import Html.App as Html
import Html.Events exposing (..)
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Array exposing (Array, get)


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



-- MODEL


type alias Model =
  { dieFace1 : Int
  , dieFace2 : Int
  }


init : (Model, Cmd Msg)
init =
  (Model 1 1, Cmd.none)



-- UPDATE


type Msg
  = Roll
  | NewFaces (Int, Int)

rollDie : Random.Generator (Int,Int)
rollDie =
    Random.pair (Random.int 1 6) (Random.int 1 6)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Roll ->
      (model, Random.generate NewFaces rollDie)

    NewFaces (newFace1, newFace2) ->
      (Model newFace1 newFace2, Cmd.none)


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none



-- VIEW

dieFaces : Array (Html Msg)
dieFaces = Array.fromList
    [ Svg.svg
      [ width "60", height "60", viewBox "0 0 60 60" ]
      [ rect [ x "2", y "2", width "56", height "56", rx "3", ry "3", fill "none", stroke "black", strokeWidth "2"] []
      , circle [ cx "28", cy "28", r "6" ] []
      ]
    , Svg.svg
      [ width "60", height "60", viewBox "0 0 60 60" ]
      [ rect [ x "2", y "2", width "56", height "56", rx "3", ry "3", fill "none", stroke "black", strokeWidth "2"] []
      , circle [ cx "20", cy "28", r "6" ] []
      , circle [ cx "40", cy "28", r "6" ] []
      ]
    , Svg.svg
      [ width "60", height "60", viewBox "0 0 60 60" ]
      [ rect [ x "2", y "2", width "56", height "56", rx "3", ry "3", fill "none", stroke "black", strokeWidth "2"] []
      , circle [ cx "15", cy "28", r "6" ] []
      , circle [ cx "30", cy "28", r "6" ] []
      , circle [ cx "45", cy "28", r "6" ] []
      ]
    , Svg.svg
      [ width "60", height "60", viewBox "0 0 60 60" ]
      [ rect [ x "2", y "2", width "56", height "56", rx "3", ry "3", fill "none", stroke "black", strokeWidth "2"] []
      , circle [ cx "20", cy "20", r "6" ] []
      , circle [ cx "40", cy "20", r "6" ] []
      , circle [ cx "20", cy "40", r "6" ] []
      , circle [ cx "40", cy "40", r "6" ] []
      ]
    , Svg.svg
      [ width "60", height "60", viewBox "0 0 60 60" ]
      [ rect [ x "2", y "2", width "56", height "56", rx "3", ry "3", fill "none", stroke "black", strokeWidth "2"] []
      , circle [ cx "15", cy "20", r "6" ] []
      , circle [ cx "30", cy "20", r "6" ] []
      , circle [ cx "45", cy "20", r "6" ] []
      , circle [ cx "15", cy "40", r "6" ] []
      , circle [ cx "30", cy "40", r "6" ] []
      ]
    , Svg.svg
      [ width "60", height "60", viewBox "0 0 60 60" ]
      [ rect [ x "2", y "2", width "56", height "56", rx "3", ry "3", fill "none", stroke "black", strokeWidth "2"] []
      , circle [ cx "15", cy "20", r "6" ] []
      , circle [ cx "30", cy "20", r "6" ] []
      , circle [ cx "45", cy "20", r "6" ] []
      , circle [ cx "15", cy "40", r "6" ] []
      , circle [ cx "30", cy "40", r "6" ] []
      , circle [ cx "45", cy "40", r "6" ] []
      ]
    ]

getDieFace : Int -> Html Msg
getDieFace n =
  case get (n - 1) ( dieFaces) of
    Just a -> a
    Nothing -> div[] [Html.text "not found"] {- FIXME should never happen? -}

view : Model -> Html Msg
view model =
  div []
    [ div []
      [ h1 [ ] [ Html.text (toString model.dieFace1) ]
      , getDieFace model.dieFace1
      ]
    , div []
      [ h1 [] [ Html.text (toString model.dieFace2) ]
      , getDieFace model.dieFace2
      ]
    , button [ onClick Roll ] [ Html.text "Roll"  ]
    ]
