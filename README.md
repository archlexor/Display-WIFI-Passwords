# Display-WIFI-Passwords
Linux/Windows

For Windows
--------------------------------------------
To view all the networks that your computer has previously connnected to: 

            netsh wlan show profile

Now that we have all the WIFI network profile visible, we can use netsh to uncover the passwords for all the visible APs.

            netsh wlan show profile name="ssid" key=clear

In the filed name="ssid" 
ssid = your saved networks names/aps.
This will show you the password under Security settings,  Key Content = <password>

