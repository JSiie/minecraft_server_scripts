#!/bin/bash

#first, we find the right place: the one containing scripts:
MINECRAFT_FOLDER=$(dirname "$(readlink -f "$0")"
#default: folder name which contains the script
SERVER_NAME=$(basename $MINECRAFT_FOLDER)
#default: minecraft_server_VERSION.jar
LAUNCH_JAR=$(basename `ls -1 $MINECRAFT_FOLDER/minecraft_server* | sort -r | head -n 1`)
#testing whether using feed the beast launcher
if test -f `$MINECRAFT_FOLDER/ServerStart.sh`; then
    LAUNCH_JAR="FTBserver*"
fi

command to see if running
run=`ps a | grep "java" | grep "$LAUNCH_JAR" | grep -v grep`

if [ -z "$run" ]
then
        echo "Minecraft server not running, restarting it"
        tmux kill-session -t $SERVER_NAME
        sleep 1
        $MINECRAFT_FOLDER/start.sh
fi

exit 0
