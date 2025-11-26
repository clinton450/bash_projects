#!/bin/bash

show_usage() {

	echo "usage : $0 <city_name>"

	echo "example: $0 delhi"

	echo "example: $0 "new york"  "

}

city="$1"

if [ -z "$city" ]; then

	echo "error : city name not provided."

	show_usage
	exit 1
fi


echo " fetching weather details for $city....."

weather=$(curl -s "https://wttr.in/${city}?format=3")

curl_status=$?

if [ $curl_status -ne 0 ] || [[ "$weather" == *"Unknown"* ]] || [[ -z "$weather" ]]; then

	echo "Error: unable to fetch weather details for  '$city' . please check if the right city name you entered ."

	echo " please check your internet connection as well"

	exit 1

fi



echo "    "

echo "===================================================="
echo "              WEATHER REPPORT                       "
echo "===================================================="

echo "$weather"

echo "==================================================="


echo "for more details , visit : https://wttr.in/${city}"













