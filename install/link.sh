#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES=${SCRIPT_DIR%/install}
BASHSCRIPTS="$DOTFILES/myBashScripts"

# DOTFILES1=$HOME/.dotfiles
# BASHSCRIPTS1=$HOME/.dotfiles/myBashScripts

echo -e "\nCreating symlinks"
echo "=============================="
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target="$HOME/.$( basename $file '.symlink' )"
    if [ -e $target ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s $file $target
    fi
done

# Still tryning neovim
echo -e "\n\nInstalling linking vimrc and neovim at ~/.config"
echo "=============================="
if [ ! -d $HOME/.config/nvim ]; then
    echo "Creating ~/.config"
    mkdir -p $HOME/.config/
    #curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    if [[ ! -d $HOME/.vim ]]; then
        mkdir -p $HOME/.vim
        ln -s $HOME/.vim $HOME/.config/nvim
    else
        ln -s $HOME/.vim $HOME/.config/nvim
    fi
fi

if [[ -e ~/.config/nvim/init.vim ]]; then
        echo "~${HOME}/.config/nvim/init.vim already exists... Skipping."
    else
        echo "Creating symlink for $HOME/.nvimrc to $HOME/.config/nvim/init.vim"
        echo 'source ~/.nvimrc' > $HOME/.config/nvim/init.vim
        #ln -s $DOTFILES/vim/vim.symlink $HOME/.config/nvim/init.vim
        ln -s $HOME/.vimrc $HOME/.nvimrc
fi

# Linking scripts
echo -e "\n\nInstalling ~/myBashScripts"
echo "=============================="
if [ ! -d $HOME/myBashScripts ]; then
    echo "Creating ~/myBashScripts"
    mkdir -p $HOME/myBashScripts
fi

linkablesScrips=$( find -H "$BASHSCRIPTS" -maxdepth 3 -name '*' )
for file in $linkablesScrips ; do
    target="$HOME/${file##*.dotfiles/}"
    if [ -e $target ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s $file $target
    fi
done

