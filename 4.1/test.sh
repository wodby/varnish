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
        if curl -s "${1}:${2}" &> /dev/null ; then
            break
        fi
        echo 'Varnish start process in progress...'
        sleep 1
    done
}

checkVarnishResponse() {
    curl -s "${1}:${2}" | grep 'Welcome to nginx!'
}

runTests() {
    host=localhost
    port=8001

    startDockerCompose
    waitForVarnish ${host} ${port}
    checkVarnishResponse ${host} ${port}
}

runCleanup() {
    stopDockerCompose
}

if [ "${1}" == 'clean' ]; then
    runCleanup
else
    runTests
fi
