#!/usr/bin/env bash

bash_GNU=$( brew --prefix bash 2> /dev/null )
if [[ ! -z $bash_GNU ]]; then
  sudo bash -c "echo $bash_GNU >> /private/etc/shells"
  chsh -s $bash_GNU
fi
