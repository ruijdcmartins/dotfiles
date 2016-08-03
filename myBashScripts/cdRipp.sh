#!/bin/bash
# This script uses ~/lameInsaneUsingFor.sh the 'cat lameInsaneUsingFor.sh' is on the end of the sript 
lameInsaneFor()
{
for f in "$@"
	do
    [[ "$f" != *.aiff ]] && continue

    lame --preset insane "$f" "${f%.aiff}.mp3"
done
}
#export -f lameInsaneUsingFor

if ls -1 $1 | grep \.aiff ; then
	FODER_TO_COPIE=$1
	echo "this folther has aiff files so is good to go!"
	echo '-------------------------------------'
	echo 'FODER_TO_COPIE' '=' $FODER_TO_COPIE
	cd ..
	
	PATH_TO_EXCLUDE=$1
	echo '-------------------------------------'
	
	cd - > /dev/null
	cd ~/Desktop/RipedCds/
	
	mkdir ~/Desktop/RipedCds"${FODER_TO_COPIE#$PATH_TO_EXCLUDE}"
	
	cd - > /dev/null
	echo '-------------------------------------'
	echo 'coping forder ' "$FODER_TO_COPIE" ' to ' "~/Desktop/RipedCds"${FODER_TO_COPIE#$PATH_TO_EXCLUDE}""
	cp -R ${1}.*aiff ~/Desktop/RipedCds"${FODER_TO_COPIE#$PATH_TO_EXCLUDE}"
	
	echo '-------------------------------------'
	echo 'FODER_COPIED' 'to' "~/Desktop/RipedCds"${FODER_TO_COPIE#$PATH_TO_EXCLUDE}""
	
	cd ~/Desktop/RipedCds"${FODER_TO_COPIE#$PATH_TO_EXCLUDE}"
	
	echo '-------------------------------------'
	echo 'starting lame for aiff in the folder' 
	
	#find . -name '*.aiff' -exec lameInsaneUsingFor.sh {} \;
	#find . -name '*.aiff' exec bash -c 'lameInsaneFor' {} \;
	find . -name '*.aiff' | while read file; do lameInsaneFor "$file"; done

	echo '-------------------------------------'
	echo "If you want to remove the .aiff files type 1"
	echo "If you want to open the folder whit the mp3s type 2"
	echo "If you want to exacute all previos options type 3"
	echo '-------------------------------------'
	echo -e "\n"
	echo -e "Please chose 1,2,3"
	
	read RESPOSTA
	case $RESPOSTA in
		1) 	rm *.aiff ;;
		2) 	open . ;;
		3) 	rm *.aiff 
			open . ;;
	esac
	cd - > /dev/null
else
	echo "NO aiff files, bad folder to run the script"
fi

#cat lameInsaneUsingFor.sh
#for f in "$@"
#	do
#    [[ "$f" != *.aiff ]] && continue
#   
#    lame --preset insane "$f" "${f%.aiff}.mp3"
#done
