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

logFolderBrew="$HOME/logs/dotfilesLogs/brewLogs/brewUpgra/"

brew_list=(	git
			#gcc
			#boost
			cmake
			cloog
			cscope
			gawk
			flac
			htop
			lame
			"macvim --with-cscope --with-lua --with-override-system-vim"
			"neovim"
			nmap
			jhead
			unrar
			wget
			yasm
			tmux
			"bash-completion" 
			#python 
			) 


if [[ $OSTYPE =~ "darwin" ]]; then
	
	if ( brew -v &> /dev/null ) ; then
		
		if [[ ! -d ${logFolderBrew} ]]; then
			mkdir -p ${logFolderBrew}
		fi
		
		brew update

		for i in `seq 0 $(( ${#brew_list[@]} -1 ))`
        do
        	if [[ "${brew_list[$i]}" == "" ]]; then continue ; fi
        	if ( brew list | grep "${brew_list[$i]%% *}" ); then  { { eval brew upgrade "${brew_list[$i]}" 2>&1 | tee ${logFolderBrew}"${brew_list[$i]%% *}".log && echo -e "<===========> \n${brew_list[$i]%% *} done" ; } || echo -e "<===========> \n${brew_list[$i]%% *} erro" ; return 1 ; } ; fi
        done
	#return 0
	fi
fi

return 0