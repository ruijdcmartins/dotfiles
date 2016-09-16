if [[ $(tmux ls | wc -l | xargs) == "0" ]] ; then tmux new -s MBP0 ; elif [[ $(tmux ls | wc -l | xargs) == "1" ]] ; then echo "tmux a" ; else echo -e "tmux a -t .......\n" ; tmux ls ; fi
