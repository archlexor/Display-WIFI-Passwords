# Display-WIFI-Passwords
Linux/Windows

For Windows
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
