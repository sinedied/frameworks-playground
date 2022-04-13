#!/bin/bash
#######################################
# Usage: ./init_frameworks.sh [--clean]
#######################################

set -e
if [ "$1" == "--clean" ]; then
  echo "Cleaning existing app & api folders..."
  rm -rf api app
fi
mkdir -p api app

# gen <name> <command> [<create_dir>]
gen() {
  name=$1
  cmd=$2
  mk_dir=$3
  echo "Generating $1..."
  if [ $mk_dir ]; then
    mkdir $name
    pushd $name > /dev/null
  fi
  bash -c "${cmd}" > /dev/null
  if [ $mk_dir ]; then
    popd > /dev/null
  fi
}

#######################################
# API frameworks
#######################################
echo "=== Generating API frameworks ==="
pushd api > /dev/null

# dotnet
gen "dotnet" "func init --worker-runtime dotnet" true
# dotnet-isolated
mkdir dotnet-isolated && pushd dotnet-isolated && func init --worker-runtime dotnetIsolated && popd
# dotnet-csx
mkdir dotnet-csx && pushd dotnet-csx && func init --worker-runtime dotnet --csx && popd
# python
mkdir python && pushd python && func init --worker-runtime python && popd
# node
mkdir node && pushd node && func init --worker-runtime node && popd
# node-ts
mkdir node-ts && pushd node-ts && func init --worker-runtime node --language typescript && popd

popd > /dev/null
#######################################
# App frameworks
#######################################
echo "=== Generating App frameworks ==="
pushd app > /dev/null

# static
mkdir static && pushd static && echo "<!doctype html><html><body>Hello</body></html>" > index.html && popd

# angular
npx -y @angular/cli@latest new angular --defaults --skip-git --skip-install --minimal

# react
npx -y create-react-app react

# vue
npx -y create-vue vue --default

