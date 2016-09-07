#!/usr/bin/env bash

###############################################################################################
#
#										TODO or not TODO
#
#	Install and Use GNU Command Line Tools on Mac OS X
#	https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
#	brew install coreutils
# 	brew tap homebrew/dupes
# 	brew install make
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

SCRIPT_DIR="${BASH_SOURCE[0]}";
if ([ -h "${SCRIPT_DIR}" ]) then
	while([ -h "${SCRIPT_DIR}" ]) do SCRIPT_DIR=`readlink "${SCRIPT_DIR}"`; done
fi
pushd . > /dev/null
cd `dirname ${SCRIPT_DIR}` > /dev/null
SCRIPT_DIR=`pwd`;
popd  > /dev/null

DOTFILES=${SCRIPT_DIR%/install}

IFS=$'\n'
brew_list=()
for A in $(brew list)
do
	brew_list+=($A)
done

if [[ $OSTYPE =~ "darwin" ]]; then
	if ! ( xcode-select -v ) ; then
	xcode-select --install ||  { echo -e "<===========> \nErro installing xcode!" ; return 1 ; }
	#return 0
	fi

	if ! ( brew -v &> /dev/null ) ; then
		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" | \
		tee ${logFolderBrew}brewInstall.log || { echo -e "<===========> \nErro brew install!" ; return 1 ; }
		brew doctor | tee ${logFolderBrew}brewDoctor.log || { echo -e "<===========> \nErro brew doc!" ; return 1  ; }
	#return 0
	fi
	
	if ( brew -v &> /dev/null ) ; then
		
		if [[ ! -d ${logFolderBrew} ]]; then
			mkdir -p ${logFolderBrew}
		fi
		
		brew update
		echo "${DOTFILES}/install/brew_install_list.txt"
		for brew_install_list in $( cat "${DOTFILES}/install/brew_install_list.txt" | \
			awk '$0 !~ /\/\// { gsub("#","") ; print $0 }' | \
			sed 's/"\(.*\)"/\1/')
		do
			fileName="${brew_install_list%% *}"
			fileName="${fileName##*/}"
			if ! ( echo  ${brew_list[@]} | grep "${brew_install_list%% *}" &> /dev/null ); then
				{ \
					{ eval 'brew install ${brew_install_list}' 2>&1 | \
					tee ${logFolderBrew}"${fileName}".log && \
					echo -e "<===========> \n${brew_install_list%% *} done" ; } || \
				echo -e "<===========> \n${brew_install_list%% *} erro" ; }
			fi
		done
	#return 0
	fi
fi
return 0
