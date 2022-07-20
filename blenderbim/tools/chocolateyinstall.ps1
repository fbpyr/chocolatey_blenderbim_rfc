$ErrorActionPreference = 'Stop'; # stop on all errors

$url64          = 'https://github.com/IfcOpenShell/IfcOpenShell/releases/download/blenderbim-220719/blenderbim-220719-py310-win.zip'
$checksum64     = 'eb2bf6cb652ff757ba37049689c8f989135d3a5d5a8931bbdd623b51beca9da8'
$checksumType64 = 'sha256'

$appDataUserDir  = [System.Environment]::GetEnvironmentVariable('appdata')
$unzipTargetDir  = "$appDataUserDir\Blender Foundation\Blender\3.2\scripts\addons"

$chocoBaseDir    = [System.Environment]::GetEnvironmentVariable('ChocolateyInstall')
$addonEnable     = "$chocoBaseDir\lib\blenderbim\tools\enable_blenderbim_addon.py"

$programFilesDir = [System.Environment]::GetEnvironmentVariable('ProgramFiles')
$blenderExePath  = "$env:ProgramFiles\Blender Foundation\Blender 3.2\blender.exe"

$processName      = "blender"
$blenderIsRunning = Get-Process -Name $processName -ErrorAction SilentlyContinue


if($blenderIsRunning -eq $null) {
    echo "attempting to install blenderbim."
    Install-ChocolateyZipPackage -PackageName $env:ChocolateyPackageName -Url64 $url64 -Checksum64 $checksum64 -checksumType $checksumType64 -UnzipLocation $unzipTargetDir
    Start-Process -FilePath  $blenderExePath -ArgumentList "-b", "-y", "--python", "$addonEnable"
}
else {
    Write-Warning "$processName is still running - blenderbim cannot be safely installed."
    Write-Warning "Please retry after closing all running blender applications."
    exit 1
}
