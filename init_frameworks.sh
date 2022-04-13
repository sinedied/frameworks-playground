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
  if [ -d $name ]; then
    echo "Skipping $name (already exists)"
    return
  fi
  echo "Generating $name..."
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
pushd api > /dev/null
echo "=== Generating API frameworks ==="

gen dotnet "func init --worker-runtime dotnet" true
gen dotnet-isolated "func init --worker-runtime dotnetIsolated" true
gen dotnet-csx "func init --worker-runtime dotnet" true
gen python "func init --worker-runtime python" true
gen node "func init --worker-runtime node" true
gen node-ts "func init --worker-runtime node --language typescript" true

#######################################
# App frameworks
#######################################
popd > /dev/null
pushd app > /dev/null
echo "=== Generating App frameworks ==="

gen static "echo '<!doctype html><html><body>Hello</body></html>' > index.html" true
gen angular "npx -y @angular/cli@latest new angular --defaults --skip-git --skip-install --minimal"
gen react "npx -y create-react-app@latest react-app && mv react-app react"
gen vue "npx -y create-vue vue --default"

