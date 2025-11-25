#!/bin/bash

# author: ghost_cyber


if [ "$EUID" -ne 0 ]; then

  echo "error please run with sudo"

  exit 1

fi


folders=("/etc" "/home/ghost/")

local_dest="/home/ghost/backups"

remote_user="ghost"

remote_ip="10.106.171.7"

remote_folder="/home/ghost/server_backups"

log="/home/ghost/bash_projects/backup.log"

time=$(date +'%Y-%m-%d_%H-%M-%S')

filename="backup_$time.tar.gz"

full_path="$local_dest/$filename"


mkdir -p "$local_dest"

echo "starting backup at $(date)........" >> "$log"


echo "compressing files........"

tar -czf "$full_path" "${folders[@]}" 2>> "$log"

if [ $? -eq 0 ]; then

  echo "local backup successful  $filename" >> "$log"

else

  echo "error: compression failed" >> "$log"

  exit 1

fi

echo "sending to remote server............."

scp "$full_path" "$remote_user@$remote_ip:$remote_folder" 2>> "$log"

if [ $? -eq 0 ]; then

  echo "upload success to $remote_ip" >> "$log"

else

  echo "error: upload failed" >> "$log"

fi

#find "$local_dest" -type f -mtime +7 -name "*.tar.gz" -exec rm {} \;

echo "backup finished successfully"



echo "finished at $(date)" >> "$log"
