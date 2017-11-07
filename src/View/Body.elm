module View.Body exposing (view)

import Common.Html.Util exposing (linkAttrs)
import Html exposing (Attribute, Html, a, div, h2, header, li, text, ul)
import Html.Attributes exposing (class, href)
import Messages exposing (Msg(..))
import Models exposing (State)
import Post.View as PostView
import Routing.Routes as Routing exposing (..)
import View.NotFound as NotFoundView


view : State -> Html Msg
view state =
    div [ class "body-wrap" ] [ bodyContent state ]


bodyContent : State -> Html Msg
bodyContent state =
    case state.route of
        HomeRoute ->
            postListView

        PostRoute postId ->
            PostView.view postId

        _ ->
            NotFoundView.view


postListView : Html Msg
postListView =
    ul [ class "post-list" ]
        [ li [ class "post-entry" ]
            [ a (postLinkAttrs (ShowPost 89) (Routing.reverse (PostRoute 89)))
                [ h2 [ class "post-header" ]
                    [ text "4 Reasons Why You Should't Punch Your Boss" ]
                ]
            ]
        ]


postLinkAttrs : Msg -> String -> List (Attribute Msg)
postLinkAttrs =
    linkAttrs "post-link"
