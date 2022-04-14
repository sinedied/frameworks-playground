#!/bin/bash
#######################################
# Usage: ./init_frameworks.sh [--clean]
#######################################

set -e
if [ "$1" == "--clean" ]; then
  echo "Cleaning existing app & api folders..."
  rm -rf samples
fi
mkdir -p samples/api samples/app

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
  if [ -z "$DEBUG" ]; then
    $cmd > /dev/null
  else
    $cmd
  fi
  if [ $mk_dir ]; then
    popd > /dev/null
  fi
}

# autoenter <command>
autoenter() {
  expect -c "
    set timeout -1
    spawn $*
    expect {
      -re \"\[?\]\" { send \"\r\"; exp_continue }
    }"
}

npx() {
  command npx -y "$@"
}

#######################################
# API frameworks
#######################################
pushd samples/api > /dev/null
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
pushd samples/app > /dev/null
echo "=== Generating App frameworks ==="

gen static "echo '<!doctype html><html><body>Hello</body></html>' > index.html" true
gen angular "npx @angular/cli@latest new angular --defaults --skip-git --skip-install --minimal"
gen react "npx create-react-app@latest react-app && mv react-app react"
gen preact "npx preact-cli@latest create default preact"
gen vue "npx create-vue@latest vue --default"
gen docusaurus "npx create-docusaurus@latest docusaurus classic --skip-install"
gen nuxtjs "npx create-nuxt-app@latest nuxtjs --answers {\"name\":\"nuxt\",\"language\":\"ts\",\"pm\":\"npm\",\"ui\":\"none\",\"target\":\"static\",\"features\":[],\"linter\":[],\"test\":\"none\",\"mode\":\"universal\",\"devTools\":[]}"
gen nextjs "npx create-next-app nextjs --use-npm"
gen vuepress "autoenter npx -y create-vuepress-site@latest vuepress"
gen aurelia "npx aurelia-cli@latest new aurelia --select"
gen gatsby "npx create-gatsby -y gatsby"
