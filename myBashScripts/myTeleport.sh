#!/bin/bash

destinyAlias=(  BASH_runnig
                testing
                my_rivet_git
                ttH_dilep )

destinyFolder=( ~/testing/Bash/runing
                "/Volumes/Dois.Tera/Dropbox/testing"
                "/Volumes/Dois.Tera/Dropbox/testing/CERN/rivet/My_Scripts"
                ~/developing/madAnalysis/madanalysis5/bin/ttH_dilep_REC5 )

counter=0
if [[ $1 == ""  ]]; then
        echo -e "The teleportation portal is set to travel to:"
        #echo -e ${destinyAlias[*]}
        for i in ${destinyAlias[@]}
        do
                echo -e "$counter \t $i \t\t ${destinyFolder[$counter]}"
                ((counter++))
        done
        unset counter
        return 0
fi

counter=0
for i in ${destinyFolder[@]}
do
        if [[ $1 == ${destinyAlias[$counter]} || $1 == $counter ]]; then
        #cd ${destinyFolder[$counter]}
        cd $i
        ls -lh
        fi
        ((counter++))
done

unset counter