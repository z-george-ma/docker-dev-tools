#!/bin/bash
CMD="$@"

function runCommand {
  exec 3< <($CMD) 
  PID=$!
}

function monitor {
  while :; do
    sleep 1
    if [ -e ".restart" ]; then
      kill $PID
      wait $PID >/dev/null 2>&1
      runCommand
      rm -rf .restart
      echo Restarted
    fi
  done
}

runCommand
monitor &
cat <&3 
