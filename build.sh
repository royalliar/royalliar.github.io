#!/bin/bash

# Enable error reporting to the console
set -e

# Build site with jekyll to '_site' folder
bundle exec jekyll build

# Cleanup
rm -rf ../theroyalliar.github.io.master

# Clone 'master' branch using encrypted GH_TOKEN for authentification
git clone https://${GH_TOKEN}@github.com/theroyalliar/theroyalliar.github.io.git ../theroyalliar.github.io.master

# Copy generated HTML site to 'master' branch
cp -R _site/* ../theroyalliar.github.io.master

# Create '.nojekyll' file
cd ../theroyalliar.github.io.master
touch .nojekyll
