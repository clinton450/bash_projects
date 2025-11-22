#!/bin/bash

websites=("google.com" "github.com" "facebook.com")

echo "checking websites ........."

for site in "${websites[@]}"; do

    ping -c 1 "$site" > /dev/null 2>&1

    if [ $? -eq 0 ]; then

        echo "$site is running ...."

    else

        echo "$site is down"
    fi

done
