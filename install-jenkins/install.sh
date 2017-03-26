#!/bin/bash

###########################################################
# 														  #
# Assumtion:											  #
# 														  #
# 	Its assumed that the current version of OSX already   #
# 	has Brew installed ... If not uncomment the 		  #
# 	"/usr/bin/ruby" line below							  #
# 														  #
###########################################################

# Install Brew
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Java through homebrew
brew cask install java

# Install Jenkins
brew install jenkins
nohup jenkins &

# Install the Android SDK
brew install android-sdk

# Install Xamarin Studio
brew cask install xamarin-studio

# Buuuuut .... we also got to install Mono
brew install wget
wget https://download.mono-project.com/archive/4.8.0/macos-10-universal/MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg
sudo installer -pkg MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg -target /

##########################
# Code Analysis Tool:	 #
# 	SonarQube			 #
##########################
brew install sonar
brew install sonar-scanner