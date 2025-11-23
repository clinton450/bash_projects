#!/bin/bash

name=$1

dir=$2

if [ -z "$dir" ]; then

    echo "Error: You missed the argument."

    exit 1

fi

if [ -d "$dir" ]; then

    echo "hey $name,  $dir exists already."

else
    mkdir -p "$dir"

    echo "Done $name  $dir  directory created successfully  "

fi
