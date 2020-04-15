set -v

# "install" bundle
mkdir -p "$HOME/Library/Application Support/TextMate/Bundles/"
ln -s $PWD "$HOME/Library/Application Support/TextMate/Bundles/Zig.tmbundle"

# run TextMate, capture output
/Applications/TextMate.app/Contents/MacOS/TextMate | tee textmate.out &

# open a sample source
mate hello.zig

# use Build command via keyboard shortcut
osascript -e 'activate application "TextMate"' -e 'tell application "System Events" to keystroke "b" using command down'

# wait for binary to be built
gtimeout 30 /bin/sh -c 'while ! ls hello 2>/dev/null; do sleep 1; done'
./hello

# don't expect the bundle to be mentioned in output as that would indicate an error
! grep Zig.tmbundle textmate.out

# debugging
# screencapture test.png; cat test.png | base64

osascript -e 'tell application "TextMate" to quit'
