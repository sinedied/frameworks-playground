#!/bin/bash

BRANCH=samples
USER_NAME=$(id -u)
USER_GROUP=$(id -g)
echo "> Current user: $USER_NAME/$USER_GROUP <"

set -e
sudo chown -R $USER_NAME:$USER_GROUP ./samples
cp .gitignore samples/
cd samples
sed -i 's/\/samples\///g' .gitignore
git config --global user.name "ci-rebot"
git config --global user.email "cirebot.github@gmail.com"
git init
git remote add origin https://$GITHUB_TOKEN@github.com/sinedied/hadra-trance-festival.git
git checkout --orphan $BRANCH
git add .
git commit -m "chore(publish): update samples"
git push -u origin $BRANCH --force

echo "Published framework samples to branch: $BRANCH"
