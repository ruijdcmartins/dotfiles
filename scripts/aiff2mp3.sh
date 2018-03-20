#!/bin/bash

# comand to use 
#find . -name '*.aiff' -exec ~/aiff2mp3.sh {} \;

for f in "$@"; do
    [[ "$f" != *.aiff ]] && continue
   
    lame --preset insane "$f" "${f%.aiff}.mp3"
done