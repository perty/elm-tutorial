module Test.Routing.Parsers exposing (tests)

import Expect exposing (..)
import Messages
import Navigation
import Routing.Parsers exposing (urlParser)
import Routing.Routes exposing (..)
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "Routing.Parsers.parse"
        [ test "HomeRoute should match index.html" <|
            \_ -> Expect.equal (urlParser indexLocation) (Messages.FollowRoute HomeRoute)
        , test "HomeRoute should match empty path" <|
            \_ -> Expect.equal (urlParser rootLocation) (Messages.FollowRoute HomeRoute)
        , test "PostRoute should match /post/89" <|
            \_ -> Expect.equal (urlParser postLocation) (Messages.FollowRoute (PostRoute 89))
        , test "PostRoute should not match wrong PostId" <|
            \_ -> Expect.notEqual (urlParser postLocation) (Messages.FollowRoute (PostRoute 102))
        ]



-- MOCK LOCATIONS


dontCare : String
dontCare =
    "Don't Care"


mockLocation : Navigation.Location
mockLocation =
    { href = dontCare
    , host = dontCare
    , hostname = dontCare
    , protocol = dontCare
    , origin = dontCare
    , port_ = dontCare
    , pathname = dontCare
    , search = dontCare
    , hash = dontCare
    , username = dontCare
    , password = dontCare
    }


indexLocation : Navigation.Location
indexLocation =
    { mockLocation | pathname = "index.html" }


rootLocation : Navigation.Location
rootLocation =
    { mockLocation | pathname = "/" }


postLocation : Navigation.Location
postLocation =
    { mockLocation | pathname = "post/89" }
