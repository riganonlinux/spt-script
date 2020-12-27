#!/bin/bash

<<COMMENT
Author : Rigan Burnwal
Date : 16th Dec, 2020
Email : riganonlinux@gmail.com
This script is meant to simplify the process of setting up themes on Spotify using spicetify, it automates the download, install and set-up process, plus provides an easy to use alias: set-spt-theme for getting the work done in an easy way, feel free to improve it or mail me suggestions.
COMMENT

clear

#set repo and install spotify deb
echo Installing the Spotify deb
cd $HOME
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client coreutils
timeout 1s spotify
read -p "Press return to continue..."
clear

#change spotify access permissions
echo Adding access to Spotify
sudo chmod a+wr /usr/share/spotify
sudo chmod a+wr /usr/share/spotify/Apps -R
read -p "Press return to continue..."
clear

#install spicetify
echo Installing and setting up Spicetify
curl -fsSL https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.sh | sh
./spicetify-cli/spicetify config prefs_path $HOME/.config/spotify/prefs
./spicetify-cli/spicetify -n backup
./spicetify-cli/spicetify -n apply
read -p "Press return to continue..."
clear

#add shortcut alias to spicetify
echo Adding alias to spicetify
echo -e "alias spotify-themes=\"ls $HOME/.config/spicetify/Themes\"" >> $HOME/.bash_aliases
echo -e "alias spicetify=\"$HOME/spicetify-cli/spicetify\"" >> $HOME/.bashrc
echo -e "alias set-theme=\"spicetify config current_theme\"" >> $HOME/.bashrc
echo -e "alias apply=\"spicetify apply\"" >> $HOME/.bashrc
source $HOME/.bashrc
read -p "Done, press return to continue..."
clear

#install themes
echo Installing git, do not worry if already installed
sudo apt install git
git clone https://github.com/morpheusthewhite/spicetify-themes.git
echo Creating Themes folder and copying themes
mkdir -vp $HOME/.config/spicetify/Themes
cd spicetify-themes
cp -r * $HOME/.config/spicetify/Themes
cd ..
rm -rf spicetify-themes
read -p "Press return to continue..."
clear

#list all the commands
echo
echo Listing all important commands :
echo spotify-themes : lists all the Spotify themes
echo set-theme : lists all the themes, lets you choose and sets it up
echo apply : applies the selected theme and restarts Spotify
echo spicetify : use this command to access spicetify directly!
echo
source ~/.bashrc
echo Enjoy your spicetify!

#delete this folder
cd $HOME
rm -rf spt-script
