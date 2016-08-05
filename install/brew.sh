#!/usr/bin/env bash

###############################################################################################
#
#										TODO or not TODO
#
#	Install and Use GNU Command Line Tools on Mac OS X
#	https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
#	brew install coreutils
#
###############################################################################################

logFolderBrew="$HOME/logs/dotfilesLogs/brewLogs/brew/"

if [[ ! -d /usr/local ]]; then
	mkdir -p /usr/local
	sudo chown -R `whoami` /usr/local
else
	if [[ $(ls -l /usr/ | grep local | awk '{print $3}') != `whoami` ]]; then
		sudo chown -R `whoami` /usr/local
	fi
fi

brew_list=(	"git"
			"gcc"
			"boost"
			"cmake"
			"cloog"
			"cscope"
			"gawk"
			"flac"
			"htop"
			"lame"
			"macvim --with-cscope --with-lua --with-override-system-vim"
			"neovim/neovim/neovim"
			"nmap"
			"jhead"
			"unrar"
			"wget"
			"yasm"
			"tmux"
			"bash-completion" 
			"homebrew/games/tty-solitaire"
			"python" ) 


if [[ $OSTYPE =~ "darwin" ]]; then
	if ! ( xcode-select -v ) ; then
	xcode-select --install ||  { echo -e "<===========> \nErro installing xcode!" ; return 1 ; }
	#return 0
	fi

	if ! ( brew -v &> /dev/null ) ; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" | tee ${logFolderBrew}brewInstall.log || { echo -e "<===========> \nErro brew install!" ; return 1 ; }
	brew doctor | tee ${logFolderBrew}brewDoctor.log || { echo -e "<===========> \nErro brew doc!" ; }
	#return 0
	fi
	
	if ( brew -v &> /dev/null ) ; then
		
		if [[ ! -d ${logFolderBrew} ]]; then
			mkdir -p ${logFolderBrew}
		fi
		
		brew update

		for i in `seq 0 $(( ${#brew_list[@]} -1 ))`
        do
        	fileName="${brew_list[$i]%% *}"
        	fileName="${fileName##*/}"
        	if ! ( brew list | grep "${brew_list[$i]%% *}" ); then { { eval brew install "${brew_list[$i]}" 2>&1 | tee ${logFolderBrew}"${fileName}".log && echo -e "<===========> \n${brew_list[$i]%% *} done" ; } || echo -e "<===========> \n${brew_list[$i]%% *} erro" ; return 1 ; }  ; fi
        done
	#return 0
	fi
fi

return 0