#/bin/bash

echo "This script loops over artist/album !!!"
echo "Must be executed on ../artist"
echo "You are in $PWD please press reurn"
read

for directorie_artist in */; do
  if [[ -d $directorie_artist ]]; then
    # echo "$directorie_artist"
    cd "$directorie_artist"
  fi
  for directorie_album in */ ; do
    if [[ -d $directorie_album ]]; then
      echo "$directorie_artist$directorie_album"
      cd "$directorie_album"
      id3tag --album="${directorie_album%/}" *.mp3
      cd ..
    fi
  done
  cd ..
done

