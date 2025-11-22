#!/bin/bash
echo "git installation scritp"

echo "installation started ......."

if [ "$(uname)" == "Linux" ]; then


        if  git --version  &> /dev/null; then

	        echo "git installed already with version $(git --version) "


        else

 		 echo "this is a linux box . installing git ..."

                 sudo apt  install git -y

	fi


elif [ "$(uname)" == "Darwin" ];

then

	echo "this is not a linux box "
	echo "it is a Macos"
	brew  install git

else
	echo "not installing"


	


fi
