module Main exposing (..)

import Messages exposing (Msg)
import Models exposing (State, newState)
import Navigation
import Routing.Parsers exposing (urlParser)
import Routing.Routes exposing (Route)
import Update exposing (..)
import View exposing (view)


main : Program Never
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }


init : Route -> ( State, Cmd Msg )
init route =
    ( newState route, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : State -> Sub Msg
subscriptions state =
    Sub.none
