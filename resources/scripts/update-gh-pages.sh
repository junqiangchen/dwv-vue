#!/bin/bash
#Script to push build results on the repository gh-pages branch.

# we should be in /home/travis/build/ivmartel/dwv-vue
echo -e "Starting to update gh-pages\n"

# build deploy version (result in ./dist)
# base href is set in config/index.js at build.assetsPublicPath
yarn run build

# go to home and setup git
cd $HOME
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis"
# using token, clone gh-pages branch
git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/ivmartel/dwv-vue.git gh-pages
# copy new build in demo/trunk
cp -Rf $HOME/build/ivmartel/dwv-vue/dist/* $HOME/gh-pages/demo/trunk
# move back to root of repo
cd $HOME/gh-pages
# add, commit and push files
git add -Af .
git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
git push -fq origin gh-pages

echo -e "Done updating.\n"