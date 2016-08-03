#!/usr/bin/env bash

logFolderPip="$HOME/dotfilesLogs/brewLogs/pip/"

pip_list=( "--upgrade pip setuptools"
			numpy
			scipy
			matplotlib
			neovim )


if !( brew -v &> /dev/null ) ; then
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install python
#return 0
fi

if ( brew -v &> /dev/null ) ; then
	
	if ! $(python -V) ; then
		brew install python
	fi

	if [[ ! -d ${logFolderPip} ]]; then
		mkdir -p ${logFolderPip}
	fi
	
	for i in `seq 0 $(( ${#pip_list[@]} -1 ))`
	do
		brew list | grep "${pip_list[$i]%% *}" || { { eval pip install "${pip_list[$i]}" | tee ${logFolderPip}"${pip_list[$i]%% *}".log && echo -e "<===========> \n${pip_list[$i]%% *} done" ; } || echo -e "<===========> \n${pip_list[$i]%% *} erro" ; }
	done
#return 0
fi

return 0