#!/bin/sh

OPTIND=1         # Reset in case getopts has been used previously in the shell.

function show_help() {
  cat <<EOF
Usage: $(basename $0) [options] tag

Options:
  -h        show this help
  -p        push to docker repository
  -c        clear previous built container
  -s        skip TLS verification
EOF
}

DOCKER_CMD='docker'
PUSH=false
CLEAR_PREV_CONTAINER=false

while getopts "h?psc" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    c)  CLEAR_PREV_CONTAINER=true
        ;;
    s)  DOCKER_CMD="$DOCKER_CMD --tlsverify=false"
        ;;
    p)  PUSH=true
        ;;
    esac
done

shift $((OPTIND-1))
[ "$1" = "--" ] && shift

TAG=$1

if [[ x"$TAG" == "x" ]]; then
  show_help
  exit 0
fi

TAG_LATEST=$TAG:latest
TAG_TIMESTAMP=$TAG:$(date +"%s")
if [[ "$CLEAR_PREV_CONTAINER" = true ]]; then
  docker rmi -f `docker images -qa $TAG`
else
  docker rmi -f $TAG
fi
docker build -t $TAG_TIMESTAMP .
docker build -t $TAG_LATEST .

if [[ "$PUSH" = true ]]; then
  docker push $TAG_TIMESTAMP
  docker push $TAG_LATEST
fi

