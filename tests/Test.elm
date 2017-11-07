module Main exposing (..)

import ElmTest exposing (Test, suite)
import Test.Routing.Parsers as ParserTest
import Test.Routing.Routes as RoutesTest


main : Program Never
main =
    ElmTest.runSuite allTests


allTests : Test
allTests =
    suite
        "All Tests"
        [ ParserTest.tests
        , RoutesTest.tests
        ]
