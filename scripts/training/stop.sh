#!/usr/bin/env bash

# docker-compose.yml uses "${ROBOMAKER_COMMAND}", so that environment
# variable needs to be available otherwise Docker outputs a (presumably
# benign) warning.  Doing an export in a shell script only applies 
# to the commands run from that script, so the export in start.sh does
# not propagate to here.
export ROBOMAKER_COMMAND="./run.sh build distributed_training.launch"
docker-compose -f ../../docker/docker-compose.yml down

docker stop $(docker ps | awk ' /sagemaker/ { print $1 }')
docker rm $(docker ps -a | awk ' /sagemaker/ { print $1 }')