#! /bin/bash

octata=1

while [ $octata -ne 256 ]; do

    if timeout 0.25s ping -c 1 "216.58.214.$octata" >/dev/null 2>&1; then
        echo "216.58.214.$octata is online"
        octata=$((octata+1))
    else
        echo "IP: 216:58.214.$octata Status: 1, General ERROR, ICMP request failed"
        octata=$((octata+1))
    fi

done