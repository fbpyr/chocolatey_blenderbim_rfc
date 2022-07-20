$appDataUserDir = [System.Environment]::GetEnvironmentVariable('appdata')
$unzippedDir = "$appDataUserDir\Blender Foundation\Blender\3.2\scripts\addons\blenderbim"

$chocoBaseDir    = [System.Environment]::GetEnvironmentVariable('ChocolateyInstall')
$addonDisable     = "$chocoBaseDir\lib\blenderbim\tools\disable_blenderbim_addon.py"

$programFilesDir = [System.Environment]::GetEnvironmentVariable('ProgramFiles')
$blenderExePath  = "$programFilesDir\Blender Foundation\Blender 3.2\blender.exe"

$processName      = "blender"
$blenderIsRunning = Get-Process -Name $processName -ErrorAction SilentlyContinue

if($blenderIsRunning -eq $null) {
    echo "attempting to uninstall blenderbim."
    Start-Process -FilePath $blenderExePath -ArgumentList "-b", "-y", "--python", "$addonDisable"
    Remove-Item -LiteralPath $unzippedDir -Force -Recurse
}
else {
    Write-Warning "$processName is still running - blenderbim cannot be safely uninstalled."
    Write-Warning "Please retry after closing all running blender applications."
    exit 1
}
