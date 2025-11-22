#!/bin/bash

echo -n "  enter the various files or the file   : "

read -r -a  FILES

for  FILE  in ${FILES[@]} ; do

echo "================ checking for files ================="

  if [  -e "$FILE" ]; then


      if [  -f  "$FILE" ]; then

         echo  " $FILE  is a regular file  "
      fi

      if [ -d "$FILE" ]; then

         echo " $FILE  is a directory"
      fi

      if [ -r "$FILE" ]; then
         echo " $FILE  is a readable file "
      fi

     if [ -w "$FILE" ]; then

        echo " $FILE  is writable " 
     fi

     if [ -x "$FILE" ]; then 
        echo " $FILE  is executable or seachable"
     fi
      filesize=$(ls -lh "$FILE" | awk '{print $5}')
      echo "   - Size: $filesize"

  else
    echo " $FILE  does not exist "

 fi


done
