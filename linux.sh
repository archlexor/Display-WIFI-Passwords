# extract wifi passwords on linux using bash 
#! /bin/bash

# Loop through all saved Wi-Fi configuration files
for i in /etc/NetworkManager/system-connections/*; do
	
    # Read each file with sudo, and extract SSID and password using awk
    sudo cat "$i" | awk -F = '
        /^ssid=/ {ssid = $2}    
        /^psk=/  {psk  = $2}       
        END 
	{print "SSID: " ssid "\npassword: " psk "\n"}'
done
