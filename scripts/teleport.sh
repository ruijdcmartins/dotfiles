#!/usr/bin/env bash

location_of_dic=~/.dotfiles/localFiles/teleport_folders.sh
location_folder_dic=~/.dotfiles/localFiles

if [[ ! -d $location_folder_dic ]]; then
  mkdir -p $location_folder_dic
fi

if [[ -e $location_of_dic ]]; then
  source $location_of_dic
else
  declare -A dic_folders
fi

add_destination(){
if [[ -z $1  ]] ; then
  folder=$PWD
else
  folder=$1
fi
echo -e "Name this teleportation folder:\n $folder"
read -ep "$(echo $'\n> ')" folder_alias
dic_folders+=(["$folder_alias"]="$folder")
}

print_dic(){
echo ""
counter=1
for key in "${!dic_folders[@]}"; do
  echo "$counter => $key - ${dic_folders[$key]}";
  ((counter++))
done
}

save_to_file(){
echo "declare -A dic_folders=(" > $location_of_dic
for key in "${!dic_folders[@]}"; do
  echo "[\"$key\"]=\"${dic_folders[$key]}\"" >> $location_of_dic;
done
echo ")" >> $location_of_dic
}

folder_by_index(){
if [[ $1 -le "${#dic_folders[@]}" ]]; then
  counter=1
  for key in "${!dic_folders[@]}"; do
    if [[ $1 -ne $counter ]]; then
      ((counter++))
      continue
    else
      cd ${dic_folders[$key]}
      break
    fi
  done
fi
}

folder_by_key(){
for key in "${!dic_folders[@]}"; do
  if [[ $key =~ $1 ]]; then
    cd ${dic_folders[$key]}
    break
  fi
done
}

#define options via flagged input arguments
check_args(){
if [[ $# -eq 0 ]] ; then
  print_dic
  read -ep "\nHere to go?$(echo $'\n> ')" choice
elif [[ $# -eq 1 ]] ; then
  choice=$1
elif [[ $# -eq 2 ]] && [[ $1 =~ -a ]] ; then
    add_destination $2
    save_to_file
fi

case $choice in
  [0-9] | [0-9][0-9])
    folder_by_index $choice
    ;;
  -a | -add)
    add_destination
    save_to_file
    ;;
  *)
    folder_by_key $choice
    ;;

esac
}

check_args $@

unset location_of_dic
unset location_folder_dic
unset dic_folders
unset folder_alias
unset folder
unset counter
unset key
unset choice
unset -f add_destination
unset -f print_dic
unset -f save_to_file
unset -f folder_by_key
unset -f folder_by_index
unset -f check_args