#!/bin/bash
if [ -z "$1" ]; then
    echo "Specify repository to install pre-push hook"
    exit 0
fi

TARGET_REPO=$1
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PRE_PUSH=$TARGET_REPO/.git/hooks/pre-push

if which aplay >/dev/null; then
    PLAYER=aplay
elif which aflay >/dev/null; then
    PLAYER=afplay
else
    echo "Could not find alsa-utils (Linux) or afplay (OSX)"
    exit 0
fi

cat > $PRE_PUSH <<EOL
#!/bin/bash

clear
aplay -q "$DIR/push-it-to-the-limit.wav" &	

sleep 1.8s 
cat "$DIR/push.txt"
sleep 0.1s 
clear
cat "$DIR/it.txt"
sleep 0.15s 
clear
cat "$DIR/to.txt"
sleep 0.15s 
clear
cat "$DIR/the.txt"
sleep 0.25s 
clear
cat "$DIR/limit.txt"

EOL
chmod +x $PRE_PUSH
echo "Created pre-push hook in $TARGET_REPO"
exit 1
