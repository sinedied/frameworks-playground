#!/bin/bash
###########################################################
# Usage: ./docker.sh <build|run> [--clean]
###########################################################

USER_NAME=$(id -u -n)
USER_GROUP=$(id -g -n)

if [ "$1" == "build" ]; then
  echo "Building container image..."
  docker build -t dev .devcontainer
elif [ "$1" == "run" ]; then
  echo "Starting container to generate framework samples..."
  docker run --user $USER_NAME:$USER_GROUP -e DEBUG=$DEBUG -t --rm -v $(pwd):/repo -w /repo dev ./create_samples.sh $2
else
  echo "Usage: ./docker.sh <build|run> [--clean]"
fi
