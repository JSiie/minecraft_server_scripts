#!/bin/bash

#first, we find the right place: the one containing scripts:
MINECRAFT_FOLDER=$(dirname "$(readlink -f "$0")")
#default: folder name which contains the script
SERVER_NAME=$(basename $MINECRAFT_FOLDER)

# saving game
tmux new-session -d -s $SERVER_NAME
tmux send -t $SERVER_NAME save-all Enter

#starting about restart to people
tmux send -t $SERVER_NAME say Space Server Space is Space going Space through Space REBOOT Space phase Space Enter

msgTimes=(30 20 10 5 4 3 2 1)
prevElement=${msgTimes[0]}
for t in ${msgTimes[@]}; do
  sleep $(expr $prevElement - $t)
  tmux send -t $SERVER_NAME say Space Restarting  Space in Space $t Space Seconds Enter
  prevElement=$t
done

tmux send -t $SERVER_NAME say Space Server Space REBOOTING Space now Space ! Enter
tmux send -t $SERVER_NAME save-all Enter
tmux send -t $SERVER_NAME stop Enter
#wait for finish
sleep 20
tmux kill-session -t $SERVER_NAME
$MINECRAFT_FOLDER/start.sh
