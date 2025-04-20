#!/usr/bin/bash

RED='\033[1;31m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
BRIGHT_GREEN='\033[1;38;5;82m'
BRIGHT_CYAN='\033[1;36m'
NC='\033[0m'

	echo -e "${BLUE}              _"   
	echo " _ __ ___ _ _| |_" 
	echo "| '_ / _ | '_|  _|"
	echo "| .__\___|_|  \__|"
	echo -e "|_| supertool${NC}"
	echo
	echo -e "${GREEN}Type \"help\" to see all commands.${NC}"
	echo
	while true; do
		echo -n ">> "
		read porttool
		case "$porttool" in
			help)
			echo "exit"
			echo "ports"
			echo "<port>"
			;;
			exit)
			break
			;;
			ports)
			echo -e "${BRIGHT_GREEN}[+] ${NC}21 22 23 445 139 135 53 80 443 110 143"
			;;
			21)
			echo -n "Enter IP: "
			read pt21
			ftp "$pt21"
			;;
			22)
			echo -n "Enter credentials (<user>@<ip>): "
			read pt22
			ssh "$pt22"
			;;
			23)
			echo -n "Enter IP: "
			read pt23
			telnet "$pt23"
			;;
			445)
			echo -n "Enter IP: "
			read pt445
			echo -n "Enter username: "
			read pt445a
			smbclient -L //"$pt445" -U "$pt445a" -N
			;;
			139)
			echo -n "Enter IP: "
			read pt139
			nbtscan "$pt139"
			;;
			135)
			echo -n "Enter IP: "
			read pt135
			rpcclient -U "" "$pt135"
			;;
			53)
			echo -n "Enter IP and domain (<ip> <domain>): "
			read pt53
			dig "$pt53"
			;;
			80)
			echo -n "Enter IP: "
			read pt80
			dirb http://"$pt80"
			;;
			443)
			echo -n "Enter IP: "
			read pt443
			dirb https://"$pt443"
			;;
			110)
			echo -n "Enter IP: "
			read pt110
			telnet "$pt110" 110
			;;
			143)
			echo -n "Enter IP: "
			read pt143
			telnet "$pt143" 143
		esac
	done
