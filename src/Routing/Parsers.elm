module Routing.Parsers exposing (urlParser)

import Messages exposing (Msg)
import Navigation
import Routing.Routes exposing (..)
import String
import UrlParser exposing ((</>), Parser, int, oneOf, s, string)


urlParser : Navigation.Location -> Msg
urlParser location =
    case UrlParser.parsePath routeParser location of
        Nothing ->
            Messages.FollowRoute NotFound

        Just route ->
            Messages.FollowRoute route



-- PAGE PARSERS


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ UrlParser.map PostRoute postParser
        , UrlParser.map HomeRoute homeParser
        ]


postParser : Parser (Int -> a) a
postParser =
    s "post" </> int


homeParser : Parser a a
homeParser =
    oneOf
        [ s "index.html"
        , s ""
        ]
