#!/bin/bash

BRANCH=samples
REPO=https://${GITHUB_TOKEN}@github.com/sinedied/frameworks-playground.git

set -e
cp .gitignore samples/
cd samples
sed -i 's/\/samples\///g' .gitignore

git init
git remote add origin $REPO
git checkout --orphan $BRANCH
git add .
git commit -m "chore(publish): update samples"
git push -u origin $BRANCH --force

echo "Published framework samples to branch: $BRANCH"
