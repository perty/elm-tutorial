#!/bin/sh

elm-package install -y
elm-make --yes TutorialTest.elm --output=test.js
node -r ./mock-document.js ./test.js
