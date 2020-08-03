#!/bin/bash

# skip if build is triggered by pull request
if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

# cleanup "_site"
rm -rf _site
mkdir _site

# clone remote repo to "_site"
git clone https://${GH_TOKEN}@github.com/chiara-rizzi/chiara-rizzi.github.io.git --branch gh-pages _site

# build with Jekyll into "_site"
#echo "bundle install"
#bundle install
echo "bundle exec jekyll build"
bundle exec jekyll build
echo "bulding done"

# push
cd _site
git config user.email "chiara_rizzi@hotmail.it"
git config user.name "Chiara Rizzi"
git add --all
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --force origin gh-pages