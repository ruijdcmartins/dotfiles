#!/usr/bin/env bash

cd $HOME/.dotfiles
gitFiles.sh * "chronos" >> $HOME/logs/crontabLogs/dotfiles.log

echo "crontab backUp dotfiles at $( time )" >> $HOME/logs/crontabLogs/dotfiles.log
