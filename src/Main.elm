module Main exposing (..)

import Html exposing (Attribute, Html, a, div, header, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (Options, onWithOptions)
import Json.Decode as Json
import Navigation
import String
import UrlParser exposing ((</>), Parser, int, oneOf, s, string)


main : Program Never State Msg
main =
    Navigation.program urlParser
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias State =
    { route : Route
    }


initialState : Route -> State
initialState route =
    { route = route
    }


init : Navigation.Location -> ( State, Cmd Msg )
init route =
    ( initialState HomeRoute, Cmd.none )



-- ROUTES


type alias PostId =
    Int


type Route
    = HomeRoute
    | PostsRoute
    | PostRoute PostId
    | NotFound



-- PARSING

{-
parse : Navigation.Location -> Route
parse { pathname } =
    let
        path =
            if String.startsWith "/" pathname then
                String.dropLeft 1 pathname
            else
                pathname
    in
    case UrlParser.parse identity routeParser path of
        Err err ->
            NotFound

        Ok route ->
            route


urlParser : Navigation.Parser Route
urlParser =
    Navigation.makeParser parse
    -}

urlParser : Navigation.Location -> Msg
urlParser location =
    case UrlParser.parsePath routeParser location of
        Nothing ->
            FollowRoute NotFound
        Just route ->
            FollowRoute route



postsParser : Parser a a
postsParser =
    s "posts"


postParser : Parser (Int -> a) a
postParser =
    s "post" </> int


homeParser : Parser a a
homeParser =
    oneOf
        [ s "index.html"
        , s ""
        ]


routeParser : UrlParser.Parser (Route -> a) a
routeParser =
    oneOf
        [ UrlParser.map PostsRoute postsParser
        , UrlParser.map PostRoute postParser
        , UrlParser.map HomeRoute homeParser
        ]



-- UPDATE


type alias Url =
    String


type Msg
    = ShowHome
    | ShowPosts
    | ShowPost PostId
    | FollowRoute Route


update : Msg -> State -> ( State, Cmd Msg )
update msg state =
    case msg of
        ShowHome ->
            ( state, Navigation.newUrl "/" )

        ShowPosts ->
            ( state, Navigation.newUrl "/posts" )

        ShowPost postId ->
            ( state, Navigation.newUrl ("/post/" ++ toString postId) )

        FollowRoute route ->
            ( { route = route }, Cmd.none)


urlUpdate : Route -> State -> ( State, Cmd Msg )
urlUpdate route state =
    ( { state | route = route }, Cmd.none )



-- VIEW


view : State -> Html Msg
view state =
    div [ class "page-wrap" ]
        [ viewHeader
        , viewBody state
        ]


viewBody : State -> Html Msg
viewBody state =
    div [ class "body-wrap" ] [ bodyContent state ]


bodyContent : State -> Html Msg
bodyContent state =
    case state.route of
        HomeRoute ->
            div [] [ text "Home Page" ]

        PostsRoute ->
            div [] [ text "Posts List" ]

        PostRoute postId ->
            div [] [ text ("Post Detail " ++ toString postId) ]

        _ ->
            div [] [ text "Not Found" ]


viewHeader : Html Msg
viewHeader =
    header
        [ class "main-header"
        ]
        [ a (linkAttrs ShowHome "/") [ text "Home" ]
        , a (linkAttrs ShowPosts "/posts") [ text "Posts" ]
        ]


linkAttrs : Msg -> String -> List (Attribute Msg)
linkAttrs message link =
    [ onClick message
    , href link
    , class "nav-link"
    ]


onClick : Msg -> Attribute Msg
onClick message =
    onWithOptions "click" noBubble (Json.succeed message)


noBubble : Options
noBubble =
    { stopPropagation = True
    , preventDefault = True
    }



-- SUBSCRIPTIONS


subscriptions : State -> Sub Msg
subscriptions state =
    Sub.none
