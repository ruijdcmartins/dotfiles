#!/usr/bin/env bash

echo "Installing dotfiles"

#echo "Initializing submodule(s)"
#git submodule update --init --recursive

echo "Linking dotedfiles to ~/."
source install/link.sh

if [ "$(uname)" == "Darwin" ]; then
    echo -e "\n\nRunning on OSX"

    source install/osxbasics.sh
    source install/brew.sh
    source install/python.sh
    source install/cask.sh
    source install/root.sh

fi

#echo "creating vim directories"
#mkdir -p ~/.vim-tmp


#echo "Configuring zsh as default shell"
#chsh -s $(which zsh)

echo "Done."

###############################################################################################
#
#										TODO or not TODO
#

# exemple: sudo installer -pkg "Command Line Tools.mpkg" -target /.
# Web links
# direct download 	https://developer.apple.com/download/more/
# HEP!! 			https://github.com/veprbl/homebrew-hep

# check ownerchip for brew etc...
# sudo chown -R `whoami` /usr/local
# sudo chown -R $(whoami):admin /usr/local

#gfortran from
#https://gcc.gnu.org/wiki/GFortranBinaries#MacOS
#MacOS
#The gfortran maintainers offer nice Apple-style installers for…….
#NOT from source 

#ls colors
# understending usual opitons http://www.marinamele.com/2014/05/customize-colors-of-your-terminal-in-mac-os-x.html
# generator with usual options http://geoff.greer.fm/lscolors/
#https://softwaregravy.wordpress.com/2010/10/16/ls-colors-for-mac/
# change and improve the ls command http://hocuspokus.net/2008/01/a-better-ls-for-mac-os-x/
