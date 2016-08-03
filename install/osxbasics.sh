#!/usr/bin/env bash

if [[ $OSTYPE =~ "darwin" ]]; then
	if ! ( xcode-select -v ) ; then
	xcode-select --install ||  { echo -e "<===========> \nErro installing xcode!" ; return 1 ; }
	#return 0
	fi
fi

if ! ( tex -v ); then
	curl -O http://tug.org/cgi-bin/mactex-download/MacTeX.pkg
	sudo installer -pkg MacTeX.pkg -target /.					# check the target !!
fi

