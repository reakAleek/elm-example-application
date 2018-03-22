module Main exposing (..)
import Msg exposing (..)
import Model exposing (..)
import View exposing (view)
import Update exposing (..)
import Html exposing (Html, div, text, program)




init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }