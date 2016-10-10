#!/usr/bin/env bash

# Adding bashrc to bash_profile
if [ "$(uname)" == "Darwin" ]; then
    echo -e "\n\nRunning on OSX"
    echo "=============================="
    if [[ ! -e $HOME/.bash_profile ]] || ( ! cat ~/.bash_profile | grep ".bashrc" ); then
        echo -e "\nLoading bashrc true bash_profile"
        echo "#!/bin/bash" >> $HOME/.bash_profile
        echo "# To Load the .bashrc automatically" >> $HOME/.bash_profile
        echo "if [ -f ~/.bashrc ];" >> $HOME/.bash_profile
        echo "then . ~/.bashrc; fi" >> $HOME/.bash_profile
    fi
fi

if [[ $OSTYPE =~ "darwin" ]]; then
	if ! ( xcode-select -v ) ; then
	xcode-select --install ||  { echo -e "<===========> \nErro installing xcode!" ; return 1 ; }
	#return 0
	fi
fi


echo "Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true 

# Enable Text Selection in Quick Look Windows
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

echo "Enable tap to click (Trackpad)"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

echo "show hidden files by default"
defaults write com.apple.Finder AppleShowAllFiles -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Change the location of dock to left 
defaults write com.apple.dock orientation left

# Change dock size
defaults write com.apple.dock tilesize -int 25

#Speed Up Mission Control Animations
#defaults write com.apple.dock expose-animation-duration -float 0.12 

echo "No dealey on opening the dock"
defaults write com.apple.dock magnification -bool false

echo "No dealey on opening the dock"
defaults write com.apple.dock autohide -bool true

echo "No dealey on opening the dock"
defaults write com.apple.dock autohide-time-modifier -int 0 

#Change the Default Screen Shot Image Type
defaults write com.apple.screencapture type jpg

#Change Where Screen Shots Are Saved To
defaults write com.apple.screencapture location ~/Pictures/Screenshots

#ScheduleFrequency set to one day
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

for myApp in Dock Finder SystemUIServer ; do killall "$myApp" >/dev/null 2>&1; done
