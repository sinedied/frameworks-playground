#!/bin/bash

BRANCH=samples

set -e
sed -i '.old' -e 's/api\///g' .gitignore
sed -i '.old' -e 's/app\///g' .gitignore
rm -f .*.old
git switch -c $BRANCH
git add .
git config --global user.name "ci-rebot"
git config --global user.email "cirebot.github@gmail.com"
git commit -m "chore(publish): add api & app folders"
git push -u origin $BRANCH --force

echo "Published framework samples to branch: $BRANCH"
