#/bin/bash

# for file in *.mp3 ; do  newName=` echo $file | perl -pe 's/(^[0-9-]+) - (.*\.mp3)/\1 \2 /' ` ;  mv "$file" "$newName" ; done

# regex='s/(^[0-9-]+) (.*\.mp3) $/\1 \2/'
# regex='s/(^[0-9-]+) - (.*\.mp3)$/\1 \2/'

# perl -ne 'if (/([0-9]+)(?: - )(.*mp3)/) { print "$1 $2" } '
# perl -ne 'if (/^([0-9-]+)?(?: - |-| -| -|\.|\. )?(.*mp3)$/) { print "$1 $2" } '

#---------- ----------#
# declare defouts
#---------- ----------#
defaultFolder="."
# defaultFolder="*/"
test="-v"
fileExtention="*.mp3"
# fileExtention="*.mp3*" # get files with space at the end
regex='/^([0-9-]+)(?: - |-| -| -|\.|\. )(.*\.mp3)$/'

# regex='/^([0-9-]+)(.*)(\.mp3\s+)$/'
#  perl -ne 'if ('"$regex"') { print "$1 $2" } '


#---------- ----------#
while [[ $1 =~ ^- ]] ; do
  case $1 in
    -e | --execute)
      test="-e"
      shift
       ;;
    -d | --directory)
      defaultFolder=$2
      shift
      shift
      ;;
    -e | --regex)
      regex=$2
      shift
      shift
      ;;
  esac
done

arrayOfFolders=($defaultFolder)

#---------- ----------#
rename() {
  # newName=` echo $1 | perl -pe "$regex" `
  newName=` echo $1 | perl -ne 'if ('"$regex"') { print "$1$2.mp3" } ' `
  if [ ! -z "$2" ] && [ "$2" == '-v' ] ; then
    echo -e "$file ->\t $newName"
  elif [ ! -z "$newName" ] ; then
    # echo "dry run $2"
    mv "$1" "$newName"
  fi
}


#---------- ----------#
# Store folders in a array and print the total number of elements
# for folder in */ ; do arrayOfFolders+=("$folder") ; done ; echo ${#arrayOfFolders[@]}
# Check the array content
# for folder in "${arrayOfFolders[@]}" ; do echo "$folder" ; done


for folder in "${arrayOfFolders[@]}" ; do
    if [[ -d "$folder" ]]; then
      echo -e "\n$folder"
      cd "$folder"
      for file in $fileExtention ; do
        rename "$file" "$test"
      done
      cd ..
    fi
done
