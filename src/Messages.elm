module Messages exposing (..)

import Routing.Routes exposing (Route)


type alias PostId =
    Int


type Msg
    = ShowHome
    | ShowPost PostId
    | FollowRoute Route
