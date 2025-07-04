#WINDOWS USING POWERSHELL
 # Retrieves all saved Wi-Fi SSIDs and stores them in $ssids
$ssids = (netsh wlan show profiles | Select-String ': ' ) -replace ".*:\s+"

foreach($ssid in $ssids){

    # Retrieves the saved Wi-Fi password for each SSID
    $password = (netsh wlan show profiles name=$SSID key=clear | Select-String 'Key Content') -replace ".*:\s+"

    # Creates a custom object (hashtable-like) containing the SSID and its corresponding password
    [PSCustomObject]@{
        SSID = $ssid
        Password = $password -ForegroundColor Red
    }
}
