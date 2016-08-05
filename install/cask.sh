#!/usr/bin/env bash

# brew cask list to check installed programs
# check bash-completion cask development 
# if brew cask install doesn't work try brew tap caskroom/cask
# brew install Caskroom/cask/xquartz

logFolderCask="$HOME/dotfilesLogs/brewLogs/cask/"

list_cask=(	"xquartz"
			"iterm2"
			"sublime-text"
			"google-chrome"
			"firefox"
			"keka"
			"flux"
			"vlc"
			"qbittorrent"
			"dropbox"
			"skype"
			"clipgrab"
			"cheatsheet"
			"torbrowser" )

if ( brew -v &> /dev/null ) ; then
		
	if [[ ! -d ${logFolderCask} ]]; then
		mkdir -p ${logFolderCask}
	fi
	
	for i in `seq 0 $(( ${#list_cask[@]} -1 ))`
	do
		fileName="${list_cask[$i]%% *}"
        fileName="${fileName##*/}"
		if ! ( brew cask list | grep "${list_cask[$i]%% *}" ); then { { eval brew cask install "${list_cask[$i]}" 2>&1 | tee ${logFolderCask}/"${fileName}".log && echo -e "<===========> \n${list_cask[$i]%% *} done" ; } || echo -e "<===========> \n${list_cask[$i]%% *} erro" ; return 1 ; } ; fi
	done
	#return 0
fi
return 0