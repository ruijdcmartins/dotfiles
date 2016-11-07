#!/usr/bin/env bash

unset ROOT_CHOICE_version
unset ROOT_CHOICE_folder
unset ROOT_MAIN_FOLDER
unset CORES
unset ROOT_CHOICE_folder_temp


#ROOT_CHOICE_version=6.06.00
ROOT_CHOICE_version=5.34.34 # last of 5.34
#ROOT_CHOICE_version=5.34.19 # on macBook

ROOT_CHOICE_folder="$ROOT_CHOICE_version"
ROOT_MAIN_FOLDER=developing

CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)
#viva o Sporting!
check_folder()
{
if [[ -d "root-$ROOT_CHOICE_folder" ]]; then
	echo -e "\n========!! Folder root-$ROOT_CHOICE_folder in ===> $ROOT_MAIN_FOLDER/root/root-$ROOT_CHOICE_folder alredy exist !!========\n"
	echo "If you want do delete and proceed the installation please type Yes(y), to exit type No(n)"
	read res_temp
	if [[ "$res_temp" == "y" || "$res_temp" == "Yes" || "$res_temp" == "yes" ]]; then
		rm -R root-"$ROOT_CHOICE_folder"
		mkdir root-"$ROOT_CHOICE_folder" ||  { echo -e "\n!! Wrong choice !!\n" ; check_folder ; }
		return 0
	fi
	if [[ $res_temp == "n" || $res_temp == "no" || $res_temp == "No" ]]; then
		echo -e "\nCreate new direcotry for the installation ? \nPlease type Yes(y), to exit type No(n)\n"
		read resposta00
		if [[ $resposta00 == "n" || $resposta00 == "no" || $resposta00 == "No" ]]; then
		exit 1
		fi
		ROOT_CHOICE_folder="$ROOT_CHOICE_version"
		if [[ "$resposta00" == "y" || "$resposta00" == "Yes" || "$resposta00" == "yes" ]]; then
		echo -e "\nThe name of the folder will be root-$ROOT_CHOICE_folder plus what you type next."
		read ROOT_CHOICE_folder_temp
		ROOT_CHOICE_folder="$ROOT_CHOICE_folder""$ROOT_CHOICE_folder_temp"
		mkdir root-"$ROOT_CHOICE_folder" ||  { echo -e "\n\n!! Wrong choice !!\n" ; check_folder ; }
		return 0
		fi
	fi
echo "ERROR"
exit 1
else
	mkdir root-"$ROOT_CHOICE_folder" ||  { echo -e "\n\n!! Wrong choice !!\n" ; check_folder ; }
	return 0
fi
}

check_thisroot()
{
# if function retuns 1, change the dotedfile
if [[ -f ~/"$1" ]]; then
	if ! ( grep -q '^ROOT_FOLDER_VERSION=' ~/"$1" ) && ! ( grep -q '^source.*thisroot.sh$' ~/"$1" ); then return 1 ; fi
	
	if ( grep -q '^ROOT_FOLDER_VERSION=' ~/"$1" ) && ( grep -q '^source.*thisroot.sh$' ~/"$1" ); then
		echo -e "\n\n===========================================\n"
		echo "Previous instalaton was detected on $1"
		echo -e "Do you want to change the variable ROOT_FOLDER_VERSION on $1 to the current version intalled?\n"
		echo "If yes ~/${1}BKUP will be created"
		echo "Please confirm Yes(y) or No(n)"
		read resposta2
		if [[ $resposta2 == "y" || $resposta2 == "Yes" || $resposta2 == "yes" ]]; then
			cp ~/"$1" ~/"$1"BKUP
			sed 's|\(^ROOT_FOLDER_VERSION=\).*|\1'"root-$ROOT_CHOICE_folder/root-$ROOT_CHOICE_version|" ~/"$1"BKUP > ~/"$1"
			echo 'source ~'"/$ROOT_MAIN_FOLDER/$ROOT_FOLDER_VERSION/bin/thisroot.sh"
			source ~/"$1"
			return 0
		fi
	else
		if ! ( grep -q '^ROOT_FOLDER_VERSION=' ~/"$1" ) && ( grep -q '^source.*thisroot.sh$' ~/"$1" ); then
			echo -e "\n\n===========================================\n"
			echo "Previous instalaton was detected on $1"
			echo -e "Do you want to comment the line source.*thisroot.sh on $1 to the current version intalled?\n"
			echo "If yes ~/${1}BKUP will be created"
			echo "Please confirm Yes(y) or No(n)"
			read resposta2
			if [[ $resposta2 == "y" || $resposta2 == "Yes" || $resposta2 == "yes" ]]; then
				cp ~/"$1" ~/"$1"BKUP
				sed 's|\(^source.*thisroot.sh$\)|#\1|g' ~/"$1"BKUP > ~/"$1"
				return 1
			fi
		fi
	fi
else
	return 1
fi	
}

apend_RootPaths()
{
echo "ROOT_TO_BE_SOURCED=root-$ROOT_CHOICE_version" >> ~/"$1"
echo "case '$ROOT_TO_BE_SOURCED' in" >> ~/"$1"
echo "	$ROOT_TO_BE_SOURCED)" >> ~/"$1"
echo -e "\n#=============== Root =================" >> ~/"$1"
echo "ROOT_FOLDER_VERSION=root-$ROOT_CHOICE_folder/root-$ROOT_CHOICE_version" >> ~/"$1"
echo 'source ~'"/$ROOT_MAIN_FOLDER/root/"'$ROOT_FOLDER_VERSION'"/bin/thisroot.sh" >> ~/"$1"
echo 'export ROOTSYS=~'"/$ROOT_MAIN_FOLDER/root/"'"$ROOT_FOLDER_VERSION"' >> ~/"$1"
echo 'export PATH=$PATH:$ROOTSYS:$ROOTSYS/bin' >> ~/"$1"
echo 'export LD_LIBRARY_PATH=$ROOTSYS/lib:$LD_LIBRARY_PATH' >> ~/"$1"
echo 'export DYLD_LIBRARY_PATH=$ROOTSYS/lib:$DYLD_LIBRARY_PATH' >> ~/"$1"
echo -e "#======================================\n" >> ~/"$1"
echo ";;" >> ~/"$1"
echo "esac" >> ~/"$1"
}

#################################################################
#################################################################
#################################################################

echo -e "\n\n==========================================="
echo -e "Root instalation \tVertion $ROOT_CHOICE_version"
echo "To change the version abort the scrip and edit the variable ROOT_CHOICE_version on this scrip"
echo "Proceed with the instalation? Type Yes(y) or No(n)"
read resposta

if [[ $resposta == "y" || $resposta == "Yes" || $resposta == "yes" ]]; then
	cd ~

	mkdir -p $ROOT_MAIN_FOLDER/root

	cd $ROOT_MAIN_FOLDER/root

	check_folder
	
	curl -o root_v"$ROOT_CHOICE_version".source.tar.gz https://root.cern.ch/download/root_v"$ROOT_CHOICE_version".source.tar.gz	 || wget -O root_v"$ROOT_CHOICE_version".source.tar.gz https://root.cern.ch/download/root_v"$ROOT_CHOICE_version".source.tar.gz || { echo -e "\nDownload failed\n" ; exit 1 ; }
	# wget -O root_v"$ROOT_CHOICE_version".source.tar.gz https://root.cern.ch/download/root_v"$ROOT_CHOICE_version".source.tar.gz || { echo -e "\nDownload failed\n" ; exit 1 ; }
	# curl -o root_v"$ROOT_CHOICE_version".source.tar.gz https://root.cern.ch/download/root_v"$ROOT_CHOICE_version".source.tar.gz || { echo -e "\nDownload failed\n" ; exit 1 ; }

	echo -e "ROOT_CHOICE_version \t\t ROOT_CHOICE_folder"
	echo -e "$ROOT_CHOICE_version \t\t\t $ROOT_CHOICE_folder"

	tar -xf root_v"$ROOT_CHOICE_version".source.tar.gz -C root-"$ROOT_CHOICE_folder" --strip-components 1 || { echo -e "\nunTar failed\n" ; exit 1 ; }

	cd root-$ROOT_CHOICE_folder

	#####################
	#
	#		osx
	#
	#####################
	
	if [[ $OSTYPE =~ "darwin" ]]; then
		
		./configure --prefix=$PWD/root-"$ROOT_CHOICE_version" --etcdir=$PWD/root-"$ROOT_CHOICE_version"/etc --enable-roofit --enable-minuit2 --enable-tmva --enable-python || { echo -e "\nConfigure failed\n" ; exit 1 ; }
	
		make -j"$CORES" || { echo -e "\nMake failed\n" ; exit 1 ; }
		make install -j"$CORES" || { echo -e "\nMake install failed\n" ; exit 1 ; }
	
		if 		( check_thisroot ".bashrc" ) ; 			then echo "Done"
		elif 	( check_thisroot ".bash_profile" ) ; 	then echo "Done"
		else apend_RootPaths ".bash_profile"
		fi
	fi


	#####################
	#
	#		linux
	#
	#####################
	
	if [[ $OSTYPE =~ "linux-gnu" ]]; then
	
		#Check if packages are installed		
		#dpkg-query -W -f='${Package} \t ${Status} ${Version}\n' {git,dpkg-dev,make,g++,gcc,binutils,libx11-dev,libxpm-dev,libxft-dev,libxext-dev}
			
		#Required packages
		sudo apt-get --yes --force-yes install git dpkg-dev make g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev
		#Optional packages
		sudo apt-get --yes --force-yes install gfortran libssl-dev libpcre3-dev \
		xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
		libmysqlclient-dev libfftw3-dev cfitsio-dev \
		graphviz-dev libavahi-compat-libdnssd-dev \
		libldap2-dev python-dev libxml2-dev libkrb5-dev \
		libgsl0-dev libqt4-dev
		
		sudo apt-get --yes --force-yes install texlive python-numpy vim
	
		./configure --prefix=$PWD/root-"$ROOT_CHOICE_version" --etcdir=$PWD/root-"$ROOT_CHOICE_version"/etc --all || { echo -e "\nConfigure failed\n" ; exit 1 ; }
		make -j"$CORES" || { echo -e "\nMake failed\n" ; exit 1 ; }
		make install -j"$CORES" || { echo -e "\nMake install failed\n" ; exit 1 ; }
	
	
		if 	( check_thisroot ".bashrc" ) ; 	then echo "Done"
		else apend_RootPaths ".bashrc"
		fi
	fi
fi
