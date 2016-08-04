#!/bin/bash

destinyAlias=(  BASH_runnig
                testing
                my_rivet_git
                ttH_dilep )

destinyFolder=( "~/myBashScripts"
                "~/Dropbox/testing"
                "~/Dropbox/testing/CERN/rivet/My_Scripts"
                "~/developing/madAnalysis/madanalysis5/bin/ttH_dilep_REC5" )

counter=0
if [[ $1 == ""  ]]; then
        echo -e "The teleportation portal is set to travel to:"
        #echo -e ${destinyAlias[*]}
        for i in ${destinyFolder[@]}
        do
                echo -e "$counter \t ${destinyAlias[$counter]} \t\t ${destinyFolder[$counter]}"
                ((counter++))
        done
        unset counter
        #return 0
        #exit 0
fi

counter=0

if [[ $1 != "" ]]; then
        for i in ${destinyFolder[@]}
        do
                if [[ $1 == ${destinyAlias[$counter]} || $1 == $counter ]]; then
                #cd ${destinyFolder[$counter]}
                eval command cd $i && ls -lh
                fi
                ((counter++))
        done
fi
unset counter