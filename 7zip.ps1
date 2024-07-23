# Define the path to 7-Zip
$sevenZipPath = "D:\2_Tool\7-Zip\7z.exe"

# Get the current script directory
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Define the source folder and output folder to be the script directory
$sourceFolder = $scriptDir
$outputFolder = $scriptDir

# Check if the 7-Zip executable exists
if (-Not (Test-Path $sevenZipPath)) {
    Write-Host "7z.exe not found at path: $sevenZipPath"
    exit 1
}

# Get all subfolders within the script directory
$subfolders = Get-ChildItem -Path $sourceFolder -Directory

foreach ($subfolder in $subfolders) {
    $subfolderPath = $subfolder.FullName
    $archiveName = $subfolder.Name + ".zip"
    $outputArchive = Join-Path -Path $outputFolder -ChildPath $archiveName

    # Execute the 7-Zip compression command
    & $sevenZipPath a $outputArchive "$subfolderPath\*"

    # Check if the compressed file was created successfully
    if (Test-Path $outputArchive) {
        Write-Host "Folder $subfolderPath successfully compressed to $outputArchive"
    } else {
        Write-Host "Compression of folder $subfolderPath failed"
    }
}

# Keep the window open
Write-Host "Press any key to exit..."
[System.Console]::ReadKey() | Out-Null