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
	source install/git.sh
	source install/python.sh
	source install/cask.sh
	# source install/latex.sh		# included in cask
	source install/root.sh
	source install/hep.sh
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
#gfortran from
#https://gcc.gnu.org/wiki/GFortranBinaries#MacOS
#MacOS
#The gfortran maintainers offer nice Apple-style installers for…….
#NOT from source 
