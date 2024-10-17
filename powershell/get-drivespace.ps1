# Function to get disk usage and output it with color
function Get-DiskUsage {
    # Get the logical disk information
    $drives = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType = 3"

    foreach ($drive in $drives) {
        $driveLetter = $drive.DeviceID
        $totalSpace = [math]::round($drive.Size / 1GB, 2)
        $freeSpace = [math]::round($drive.FreeSpace / 1GB, 2)
        $usedSpace = $totalSpace - $freeSpace
        $percentFree = [math]::round(($freeSpace / $totalSpace) * 100, 2)

        # Determine color based on usage
        if ($percentFree -ge 20) {
            $color = 'Green'
        } elseif ($percentFree -lt 20 -and $percentFree -ge 10) {
            $color = 'Yellow'
        } else {
            $color = 'Red'
        }

        # Output disk usage information with color
        Write-Host "$driveLetter : Total: $totalSpace GB, Used: $usedSpace GB, Free: $freeSpace GB ($percentFree% Free)" -ForegroundColor $color
    }
}

# Start running the disk usage report immediately when the script runs
Begin {
    Get-DiskUsage
}

