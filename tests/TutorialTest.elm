module Main exposing (..)

import Test exposing (Test, describe)
import Test.Routing.Parsers as ParserTest
import Test.Routing.Routes as RoutesTest
import Test.Runner.Html


main : Test.Runner.Html.TestProgram
main =
    allTests
        |> Test.Runner.Html.run


allTests : Test
allTests =
    describe "All Tests"
        [ ParserTest.tests
        , RoutesTest.tests
        ]
