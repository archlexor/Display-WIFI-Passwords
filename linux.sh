#!/bin/bash

# Loop through all saved Wi-Fi configuration files
for i in /etc/NetworkManager/system-connections/*; do
	
    # Read each file with sudo (since most are root-owned), and extract SSID and password using awk
    sudo cat "$i" | awk -F = '
        /^ssid=/ {ssid = $2}       # If the line starts with 'ssid=', save the value to variable 'ssid'
        /^psk=/  {psk  = $2}       # If the line starts with 'psk=', save the value to variable 'psk'
        END {                     # At the end of the file, print the results
            print "SSID: " ssid "\npassword: " psk "\n"
        }
    '

done
