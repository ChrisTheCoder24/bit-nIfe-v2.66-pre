#!/usr/bin/bash

BLUE='\033[1;34m'
GREEN='\033[1;32m'
NC='\033[0m'

echo -e "${BLUE}  ___ __ __ _ _ _  "
echo " (_-</ _/ _' | ' \ "
echo " /__/\__\__,_|_||_|"
echo -e "      supertool${NC}"
echo
echo -e "${GREEN}Type \"help\" to see all commands.${NC}"
while true; do
	echo -n ">> "
	read scantool
	if [ "$scantool" == "exit" ]; then
		break
	elif [ "$scantool" == "help" ]; then
		echo "exit"
		echo "nmap ..."
	elif [ "${scantool:0:5}" == "nmap " ]; then
		eval "$scantool"
	fi
done
