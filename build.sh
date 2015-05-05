#!/bin/bash

# Enable error reporting to the console
set -e

# Install gsl library
apt-get install libgsl0ldbl

# Build site with jekyll, by default to '_site' folder
bundle exec jekyll build

# Cleanup
rm -rf ../theroyalliar.github.io.master

# Clone 'master' branch of the repository using encrypted GH_TOKEN for authentication
git clone https://${GH_TOKEN}@github.com/theroyalliar/theroyalliar.github.io.git ../theroyalliar.github.io.master

# Copy generated HTML site to 'master' branch
cp -R _site/* ../theroyalliar.github.io.master

# Commit and push generated content to 'master' branch
cd ../theroyalliar.github.io.master
touch .nojekyll
git config user.email "${GIT_EMAIL}"
git config user.name "${GIT_NAME}"
git add -A .
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --quiet origin master > /dev/null 2>&1
