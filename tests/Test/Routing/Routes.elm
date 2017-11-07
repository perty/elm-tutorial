module Test.Routing.Routes exposing (tests)

import Expect
import Routing.Routes exposing (..)
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "Routing.Routes.reverse"
        [ test "HomeRoute should reverse to '/'" <|
            \_ -> Expect.equal "/" (reverse HomeRoute)
        , test "NotFound should reverse to '/'" <|
            \_ -> Expect.equal "/" (reverse NotFound)
        , test "PostRoute 89 should reverse to '/post/89'" <|
            \_ -> Expect.equal "/post/89" (reverse (PostRoute 89))
        ]
