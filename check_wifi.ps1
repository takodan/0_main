# Define the name of the Wi-Fi adapter or Wi-Fi SSID
$wifiAdapterName = "Wi-Fi"
$wifiName = "Wi-Fi"

# Function to check internet connection
function Test-InternetConnection {
    try {
        # Try to ping Google DNS 8.8.8.8
        $ping = Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet
        return $ping
    } catch {
        return $false
    }
}

# Main loop, runs indefinitely
while ($true) {
    Write-Host "Checking internet connection..." -ForegroundColor Yellow

    # Check the internet connection
    if (-not (Test-InternetConnection)) {
        Write-Host "Cannot connect to the internet, restarting Wi-Fi..." -ForegroundColor Red

        # Disable Wi-Fi
        # Disable-NetAdapter -Name $wifiAdapterName -Confirm:$false
	netsh wlan disconnect

        # Wait for 30 seconds
        Start-Sleep -Seconds 30

        # Enable Wi-Fi
        # Enable-NetAdapter -Name $wifiAdapterName -Confirm:$false
        netsh wlan connect $wifiName

        Write-Host "Wi-Fi has been restarted" -ForegroundColor Yellow
    } else {
        Write-Host "Internet connection is fine" -ForegroundColor Green
    }

    # Wait for 3 minutes (180 seconds)
    Start-Sleep -Seconds 180
}