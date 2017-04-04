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

# Install Java through homebrew
brew cask install java

# Install Jenkins
brew install jenkins
nohup jenkins &

# Install the Android SDK
brew cask install android-sdk

# Install Xamarin Studio
brew cask install xamarin-studio

# Buuuuut .... we also got to install Mono
brew install wget
wget https://download.mono-project.com/archive/4.8.0/macos-10-universal/MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg
sudo installer -pkg MonoFramework-MDK-4.8.0.520.macos10.xamarin.universal.pkg -target /
sudo chmod 775 /Library/Frameworks/Mono.framework/Versions/Current/bin/mono

# And .... the .Net core
brew update
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
brew install mercurial
git clone https://github.com/nelsonsar/StyleCop.Baboon

cd StyleCop.Baboon
sudo hg clone https://hg.codeplex.com/stylecop
make # runs nuget and xbuild

sudo chmod 775 StyleCop.Baboon/bin/Debug/StyleCop.Baboon.exe

# Install Mono-Tools (for Gendarme) ... 
# Currently only install Gendarme
wget https://cloud.github.com/downloads/spouliot/gendarme/gendarme-2.10-bin.zip
unzip gendarme-2.10-bin.zip

# Installation from source currently a work in progress
# brew install autoconf pkg-config readline automake gettext glib intltool libtool
# git clone https://github.com/mono/mono-tools
# cd mono-tools
# PKG_CONFIG_PATH=/Library/Frameworks/Mono.framework/Versions/Current/lib/pkgconfig/
# export PKG_CONFIG_PATH
# ./autogen.sh
