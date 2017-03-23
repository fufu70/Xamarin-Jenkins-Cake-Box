#!/bin/bash

# Install Brew locally
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Java through homebrew
brew cask install java

# Install Jenkins
brew install jenkins