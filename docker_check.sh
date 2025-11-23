#!/bin/bash

echo "docker status checker started .........."


status="`systemctl status docker |awk 'NR==3 {print}' |cut -d ':' -f 2|cut -d '(' -f 1`"

echo "$status"

if [ status = "active" ];  then

	echo "docker service is running........"

else

	echo "the service docker is down "
	systemctl start  docker

fi

