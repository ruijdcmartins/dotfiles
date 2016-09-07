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

SCRIPT_DIR="${BASH_SOURCE[0]}";
if ([ -h "${SCRIPT_DIR}" ]) then
  while([ -h "${SCRIPT_DIR}" ]) do SCRIPT_DIR=`readlink "${SCRIPT_DIR}"`; done
fi
pushd . > /dev/null
cd `dirname ${SCRIPT_DIR}` > /dev/null
SCRIPT_DIR=`pwd`;
popd  > /dev/null

DOTFILES=${SCRIPT_DIR%/myBashScripts}

IFS=$'\n'
brew_list=()
for A in $(brew list)
do
	brew_list+=($A)
done

if [[ $OSTYPE =~ "darwin" ]]; then

	if ( brew -v &> /dev/null ) ; then

		if [[ ! -d ${logFolderBrew} ]]; then
			mkdir -p ${logFolderBrew}
		fi
		echo "brew update"
		brew update

		for brew_upgrade_list in $( cat ${DOTFILES}/install/brew_install_list.txt | \
			awk '$0 !~ /(#|\/\/)/ { ; print $0 }' | \
			sed 's/"\(.*\)"/\1/')
		do
			fileName="${brew_upgrade_list%% *}"
			fileName="${fileName##*/}"
			if [[ "${brew_upgrade_list}" == "" ]]; then continue ; fi
			if ( echo ${brew_list[@]} | grep "${brew_upgrade_list%% *}" > /dev/null ); then  
				{ { eval 'brew upgrade ${brew_upgrade_list%% *}' 2>&1 | \
					tee -a ${logFolderBrew}"${fileName}".log && echo -e "<===========> \n${brew_upgrade_list%% *} done" ; } || \
				echo -e "<===========> \n${brew_upgrade_list%% *} erro" ; } ; fi
		done
	#return 0
	fi
fi

