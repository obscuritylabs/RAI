#!/bin/bash
#DNS Redirection Script
# <@real_slacker007>


ERROR="EXAMPLE USAGE: ./dns_redir.sh 192.168.1.5 2224" 
EX="dns_redir.sh (ip-to-fwd-to) (port-to-fwd-on)"

# Check CMD line args
if [ $1 == "help" ]; then
	echo ""
	echo $EX
	echo $ERROR
	echo ""
	exit 1
fi
if [[ $1 == "" ]] || [[ $2 == "" ]]; then
	echo "ERROR: Check Syntax" 
	echo $ERROR
	exit 1
fi 
if [[ $2 -lt 1025 ]] || [[ $2 -gt 65535 ]]; then 
	echo "ERROR: Invalid Port"
	echo "Ensure that the destination port is within [1025-65535] range"
	exit 1
fi 

IPADDR=$1
PORT=$2
green=`tput setaf 2`
reset=`tput sgr0`

echo "1" > "/proc/sys/net/ipv4/ip_forward"

iptables -I INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -t nat -A PREROUTING -i eth0  -p udp --dport 53 -j DNAT --to "$IPADDR:$PORT"
iptables -t nat -A POSTROUTING -p udp -d $IPADDR --dport $PORT -j MASQUERADE
iptables -I FORWARD -j ACCEPT
iptables -P FORWARD ACCEPT
iptables -L -v
echo ""
echo "${green}SetUp Complete!${reset}"



