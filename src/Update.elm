module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (State)
import Navigation
import Routing.Parsers exposing (urlParser)
import Routing.Routes as Routing exposing (..)


update : Msg -> State -> ( State, Cmd Msg )
update msg state =
    case msg of
        ShowHome ->
            ( state, Navigation.newUrl (Routing.reverse HomeRoute) )

        ShowPost postId ->
            let
                postPath =
                    Routing.reverse (PostRoute postId)
            in
            ( state, Navigation.newUrl postPath )


urlUpdate : Route -> State -> ( State, Cmd Msg )
urlUpdate route state =
    ( { state | route = route }, Cmd.none )
