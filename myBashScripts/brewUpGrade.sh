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

IFS_ORIGINAL=$IFS
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
			sed -n 's/.*#.*// ; /\/\//!p' )
		do
			IFS=$IFS_ORIGINAL
			fileName="${brew_upgrade_list%% *}"
			fileName="${fileName##*/}"
			if [[ "${brew_upgrade_list}" == "" ]]; then continue ; fi
			if ( echo ${brew_list[@]} | grep "${brew_upgrade_list%% *}" > /dev/null ); then  
				{ 
					echo -e "<===========> start ${brew_upgrade_list%% *} start <===========> "
					echo "brew upgrade ${brew_upgrade_list%% *}"
					{ 
						eval 'brew upgrade ${brew_upgrade_list%% *}' 2>&1 | \
						tee -a ${logFolderBrew}"${fileName}".log && \
						echo -e "<===========> ${brew_upgrade_list%% *} done <===========>\n" ;
					} || \
				echo -e "<===========> ${brew_upgrade_list%% *} erro <===========>\n\n\n" ; }
			fi
		done
	fi
fi

