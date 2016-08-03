#!/usr/bin/env bash

echo "Installing dotfiles"

#echo "Initializing submodule(s)"
#git submodule update --init --recursive

echo "Linking dotedfiles to ~/."
source install/link.sh

if [ "$(uname)" == "Darwin" ]; then
    echo -e "\n\nRunning on OSX"

    source install/brew.sh

    source install/osx.sh
fi

#echo "creating vim directories"
#mkdir -p ~/.vim-tmp


#echo "Configuring zsh as default shell"
#chsh -s $(which zsh)

echo "Done."
