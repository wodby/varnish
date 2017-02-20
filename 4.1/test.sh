#!/usr/bin/env bash

set -ex

startDockerCompose() {
    docker-compose -f test/docker-compose.yml up -d
}

stopDockerCompose() {
    docker-compose -f test/docker-compose.yml down
}

waitForVarnish() {
    for i in {30..0}; do
        if curl -s "$url" &> /dev/null ; then
            break
        fi
        echo 'Varnish start process in progress...'
        sleep 1
    done
}

checkVarnishResponse() {
    curl -s "$url" | grep 'Welcome to nginx!'
}

url=localhost:8001

startDockerCompose
waitForVarnish
checkVarnishResponse
stopDockerCompose