#!/bin/bash
# ./gitUpdate.sh file1 file2 .... fileN "commit mesage"
git pull
	
while (( "$#" )); do
	if [ $# -gt 1 ]; then
		git add "$1"
	fi
	
	if [ $# == 1 ]; then
		git commit -m "$1"
		git push
	fi

	shift
done

#git fetch --all
#git reset --hard origin/master
#or
#git reset --hard origin/your_branch #will remove all uncommitted changes from your working directory.
#or
#git pull

#1st do some commits?
#git checkout master 
#git branch new-branch-to-save-current-commits 
#git fetch --all 
#git reset --hard origin/master

#git reset git.sh
#git checkout git.sh
#git pull


#git checkout master
#git fetch --all
#git pull