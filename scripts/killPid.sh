#!/usr/bin/env bash
echo

unset my_Program_name
unset all_infoPid
unset number_of_matches
unset var


my_Program_name=$( echo $@ | awk '{print $1}' )
promgas_found=$( ps aux | grep -i "$my_Program_name" )

all_infoPid=$( echo "$promgas_found" | awk '{$1=$3=$4=$5=$6=$7=$8=$9=$10="" ; print $0 }' )
number_of_matches=$( echo "$all_infoPid" | wc -l | sed "s/ *\([1-9]*\)*/\1/" )
var=1

echo " PID       Index    COMMAND"

while (( $number_of_matches >=  $var )); do
	echo "============ $var ============"
	echo -e "$all_infoPid" | sed -n "${var}p"
	((var+=1))
done

echo -e "===========================\n"
read -ep "Please choose indices to kill separated with a sapace $(echo $'\n> ')" killNumber

var=1

while (( $number_of_matches >=  $var )); do
  if [[ "$killNumber" =~ ^[Aa](ll)? ]]; then
    echo -e "$all_infoPid" | sed -n "${var}p" | awk '{ print $1 }' | xargs kill -9 && echo -e "$all_infoPid" | sed -n "${var}p" | awk '{ print $0 " !! Was killd !!" }'
  else 
    for i in $killNumber ; 
    do
      if [[ "$var" =~ "$i"$ ]]; then
        echo -e "$all_infoPid" | sed -n "${var}p" | awk '{ print $1 }' | xargs kill -9 && echo -e "$all_infoPid" | sed -n "${var}p" | awk '{ print $0 " !! Was killd !!" }'
      fi
    done
  fi
	((var+=1))
done
