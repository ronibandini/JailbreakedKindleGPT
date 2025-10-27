#!/bin/sh
# Name: Start Telnet
# Author: HackerDude
# Icon:
killall telnetd &> /dev/null
ip_addr=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

echo "Telnet Started On: $ip_addr : 23"
sleep 5

iptables -A INPUT -p tcp --dport 23 -j ACCEPT
telnetd -l /bin/sh -p 23