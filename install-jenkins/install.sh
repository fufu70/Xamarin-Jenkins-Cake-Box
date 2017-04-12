#!/bin/bash

###########################################################
#                                                         #
# Assumtion:                                              #
#                                                         #
#   Its assumed that the current version of OSX already   #
#   has Brew installed ... If not uncomment the           #
#   "/usr/bin/ruby" line below                            #
#                                                         #
###########################################################

# Install Brew
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

# Install Java through homebrew
brew cask install java

# Install Jenkins
brew install jenkins
nohup jenkins &

# Install the Android SDK
brew install android-sdk

# Install Xamarin Studio
brew cask install xamarin-studio
brew cask install xamarin-android

# Update android SDK
( sleep 5 && while [ 1 ]; do sleep 1; echo y; done ) | android update sdk --no-ui --use-sdk-wrapper -u -a -t android-15,android-16,android-17,android-18,android-19,android-20,android-21,android-22,android-23,android-24,android-25

# Buuuuut .... we also got to install Mono
brew install wget
wget https://download.mono-project.com/archive/4.8.0/macos-10-universal/MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg
sudo installer -pkg MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg -target /
sudo chmod 775 /Library/Frameworks/Mono.framework/Versions/Current/bin/mono

# And .... the .Net core
brew install openssl
mkdir -p /usr/local/lib
ln -s /usr/local/opt/openssl/lib/libcrypto.1.0.0.dylib /usr/local/lib/
ln -s /usr/local/opt/openssl/lib/libssl.1.0.0.dylib /usr/local/lib/
ln -s /usr/local/share/dotnet/dotnet /usr/local/bin


##########################
# Code Analysis Tool:    #
#   PMD (CPD)            #
#   StyleCop             #
#   Gendarme             #
##########################

# Install PMD
brew install pmd

# Install StyleCop
# @link https://github.com/nelsonsar/StyleCop.Baboon
cd /Users/vagrant
brew install mercurial
git clone https://github.com/nelsonsar/StyleCop.Baboon

cd StyleCop.Baboon
sudo hg clone https://hg.codeplex.com/stylecop
make # runs nuget and xbuild

sudo chmod 775 StyleCop.Baboon/bin/Debug/StyleCop.Baboon.exe


# Install Mono-Tools (for Gendarme) ... 
# Currently only install Gendarme
cd /Users/vagrant
wget https://cloud.github.com/downloads/spouliot/gendarme/gendarme-2.10-bin.zip
unzip gendarme-2.10-bin.zip

# TODO Installation from source currently a work in progress
# brew install autoconf pkg-config readline automake gettext glib intltool libtool
# git clone https://github.com/mono/mono-tools
# cd mono-tools
# PKG_CONFIG_PATH=/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig/
# export PKG_CONFIG_PATH
# ./autogen.sh