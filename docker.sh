#!/bin/bash
###########################################################
# Usage: ./docker.sh <build|run> [--clean]
###########################################################

if [ "$1" == "build" ]; then
  echo "Building container image..."
  docker build -t dev .devcontainer
elif [ "$1" == "run" ]; then
  echo "Starting container to generate framework samples..."
  docker run  -e DEBUG=1 --rm -v $(pwd):/repo -w /repo dev ./init_frameworks.sh $2
else
  echo "Usage: ./docker.sh <build|run> [--clean]"
fi
