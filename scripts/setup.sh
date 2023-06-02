#!/usr/bin/env bash

echo -e ''
echo -e '\e[1;33mLoading docker environment variables...\e[0m'
DOCKER_ENVIRONMENT_FILE='./../.env'
if [ ! -f ${DOCKER_ENVIRONMENT_FILE} ]; then
    echo -e '\e[1;31mError:\e[0m'' ''file'' '${DOCKER_ENVIRONMENT_FILE}' ''does not exist'
    exit
fi
./docker-environment.sh && source /tmp/.docker-environment.sh && rm /tmp/.docker-environment.sh
