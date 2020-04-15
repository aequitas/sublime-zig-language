#!/bin/bash

# run testsuite locally

set -e

# reset environment
osascript -e 'tell application "TextMate" to quit'
rm -rf "$HOME/Library/Application Support/TextMate/Bundles/Zig.tmbundle"

# remove artifacts
rm -f hello.o hello textmate.out

. .github/workflows/test.sh
