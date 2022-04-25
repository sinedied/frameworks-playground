#!/bin/bash
###########################################################
# Usage: ./docker.sh <build|run|shell> [--clean]
###########################################################

if [ -z "$DOCKER_USER" ]; then
  DOCKER_USER=vscode
fi

if [ "$1" == "build" ]; then
  echo "Building container image..."
  docker build -t dev .devcontainer
elif [ "$1" == "run" ]; then
  echo "Starting container to generate framework samples..."
  docker run -e DEBUG=$DEBUG -u $DOCKER_USER -t --rm -v $(pwd):/repo -w /repo dev ./create_samples.sh $2
elif [ "$1" == "shell" ]; then
  echo "Starting container with interactive shell..."
  docker run -e DEBUG=$DEBUG -u $DOCKER_USER -it --rm -v $(pwd):/repo -w /repo dev bash
else
  echo "Usage: ./docker.sh <build|run|shell> [--clean]"
fi
