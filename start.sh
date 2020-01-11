#!/bin/bash

#first, we find the right place: the one containing scripts:
MINECRAFT_FOLDER=$(dirname "$(readlink -f "$0")"
#default: folder name which contains the script
SERVER_NAME=$(basename $MINECRAFT_FOLDER)
#default: minecraft_server_VERSION.jar
LAUNCH_COMMAND=`ls -1 $MINECRAFT_FOLDER/minecraft_server* | sort -r | head -n 1`

#testing whether using feed the beast launcher
if test -f `$MINECRAFT_FOLDER/ServerStart.sh`; then
    LAUNCH_COMMAND="$MINECRAFT_FOLDER/ServerStart.sh"
fi

# create the new tmux session for the server
tmux new-session -d -s $SERVER_NAME
tmux send -t $SERVER_NAME sh Space $LAUNCH_COMMAND Enter
