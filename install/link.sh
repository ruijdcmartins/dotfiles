#!/usr/bin/env bash

DOTFILES=$HOME/.dotfiles
BASHSCRIPTS=$HOME/.dotfiles/myBashScripts

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
    else
        ln -s $HOME/.vim $HOME/.config/nvim
    fi
fi

if [[ -L ~/.config/nvim/init.vim ]]; then
        echo "~${HOME}/.config/nvim/init.vim already exists... Skipping."
    else
        echo "Creating symlink for $HOME/.config/nvim/init.vim"
        ln -s $DOTFILES/vim/vim.symlink $HOME/.config/nvim/init.vim
fi

# Linking scripts
echo -e "\n\nInstalling ~/myBashScripts"
echo "=============================="
if [ ! -d $HOME/myBashScripts ]; then
    echo "Creating ~/myBashScripts"
    mkdir -p $HOME/myBashScripts
fi

linkablesScrips=$( find -H "$BASHSCRIPTS" -maxdepth 3 -name '*.sh' )
for file in $linkablesScrips ; do
    target="$HOME/${file##*.dotfiles/}"
    if [ -e $target ]; then
        echo "~${target#$HOME} already exists... Skipping."
    else
        echo "Creating symlink for $file"
        ln -s $file $target
    fi
done

#echo -e "\n\ninstalling to ~/.config"
#echo "=============================="
#if [ ! -d $HOME/.config ]; then
#    echo "Creating ~/.config"
#    mkdir -p $HOME/.config
#fi
#       # configs=$( find -path "$DOTFILES/config.symlink" -maxdepth 1 )
#for config in $DOTFILES/config/*; do
#    target=$HOME/.config/$( basename $config )
#    if [ -e $target ]; then
#        echo "~${target#$HOME} already exists... Skipping."
#    else
#        echo "Creating symlink for $config"
#        ln -s $config $target
#    fi
#done

# create vim symlinks
# As I have moved off of vim as my full time editor in favor of neovim,
# I feel it doesn't make sense to leave my vimrc intact in the dotfiles repo
# as it is not really being actively maintained. However, I would still
# like to configure vim, so lets symlink ~/.vimrc and ~/.vim over to their
# neovim equivalent.

#echo -e "\n\nCreating vim symlinks"
#echo "=============================="
#
#typeset -A vimfiles
#vimfiles[~/.vim]=$DOTFILES/config/nvim
#vimfiles[~/.vimrc]=$DOTFILES/config/nvim/init.vim
#
#for file in "${!vimfiles[@]}"; do
#    if [ -e ${file} ]; then
#        echo "${file} already exists... skipping"
#    else
#        echo "Creating symlink for $file"
#        ln -s ${vimfiles[$file]} $file
#    fi
#done
