# Display-WIFI-Passwords
Linux/Windows

For Windows(powershell)
--------------------------------------------
To view all the networks that your computer has previously connnected to: 
```
netsh wlan show profile
```
Now that we have all the WIFI network profile visible, we can use netsh to uncover the passwords for all the visible APs.
```
netsh wlan show profile name="ssid" key=clear
```
In the filed name="ssid" <br>
ssid = your saved networks names/aps. <br>
This will show you the password under Security settings,  Key Content = 'wifi_password' <br>
<br>

If you want to saved the output to a file you can use this code below: 
```
# Retrieves all saved Wi-Fi SSIDs and stores them in $ssids
$ssids = (netsh wlan show profiles | Select-String ': ' ) -replace ".*:\s+"

foreach($ssid in $ssids){
            # Retrieves the saved Wi-Fi password for each SSID
            $password = (netsh wlan show profiles name=$SSID key=clear | Select-String 'Key Content') -replace ".*:\s+"

            # Creates a custom object (hashtable-like) containing the SSID and its corresponding password
            [PSCustomObject]@{
                        SSID = $ssid
                        Password = $password
            }
} | Out-File -FilePath "$env:USERPROFILE\Downloads\pass.txt"
```
This will save the passwords into your Downloads directory.


## For Linux(bash) 
To view content of /etc/NetworkManager/system-connections/ directory you will need to have root privelage.

do 
```
cd /etc/NetworkManager/system-connections/
```
if you do ls to list the files you will see bunch of saved networks profile 
```
ls
```
now all you have to do is: 
```
sudo cat <ssid>.nmconnection
```
you will see a bunch of information however the required password is labeled as psk='password'
use this to filter out just the password 
```
sudo cat <ssid>.nmconnection | awk -F: '/^psk/'
```
This should work on most Linux distributions that use NetworkManager (e.g., Kali, Ubuntu, Fedora).
However, there might be exceptions.

💡 Tip: The tool `nmcli` can also retrieve saved network information:
Example: 
```
nmcli connection show
```
or 
```
nmcli -s -g 802-11-wireless-security.psk connection show <profile>
```
But note that `nmcli` is not preinstalled on all minimal distros.



