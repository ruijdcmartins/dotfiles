if [[ $(tmux ls | wc -l | xargs) == "0" ]] ; then
	tmux new -s $(hostname -s) ;
elif [[ $(tmux ls | wc -l | xargs) == "1" ]] ; then
	tmux a ;
else echo -e "tmux a -t .......\n" ;
	tmux ls ;
fi
