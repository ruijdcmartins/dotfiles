#!/usr/bin/env bash

# brew cask list to check installed programs
# check bash-completion cask development 
# if brew cask install doesn't work try brew tap caskroom/cask
# brew install Caskroom/cask/xquartz

logFolderCask="$HOME/dotfilesLogs/brewLogs/cask/"

list_install_cask=(	"xquartz"
			"iterm2"
			"sublime-text"
			"google-chrome"
			"firefox"
			"keka"
			"flux"
			"vlc"
			"djview"
			"dropbox"
			"skype"
			"clipgrab"
			"cheatsheet"
			"torbrowser"
			"subtitle-master"
			"virtualbox"
			"virtualbox-extension-pack"
			"soundflower"
			"Caskroom/cask/deluge"
			"soulseek"
			"icefloor"
			"mactex")


IFS_ORIGINAL=$IFS
IFS=$'\n'
brew_list=()
for A in $(brew cask list)
do
	brew_list+=($A)
done

if ( brew -v &> /dev/null ) ; then
		
	if [[ ! -d ${logFolderCask} ]]; then
		mkdir -p ${logFolderCask}
	fi
	
	for list in ${list_install_cask[@]}
	do
		IFS=$IFS_ORIGINAL
		fileName="${list%% *}"
		fileName="${fileName##*/}"
		if ! ( echo ${brew_list[@]} | grep "${list%% *}" ); then 
			{ 
				{
				echo -e "<===========> start ${list%% *} start <===========> ";
				eval 'brew cask install ${list}' 2>&1 | tee ${logFolderCask}/"${fileName}".log && \
				echo -e "<===========> done ${list%% *} done <===========> " ;
				} || \
				echo -e "<===========> erro ${list%% *} erro <===========> " ;
				}
		fi
	done
	#return 0
fi
return 0
