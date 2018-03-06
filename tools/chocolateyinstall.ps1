$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageName = 'sim'
$filePath = "$env:TEMP\chocolatey\$packageName"
$fileFullPath = "$filePath\${packageName}.application"
$url = 'http://dl.sitecore.net/updater/sim/SIM.Tool.application'

$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$ahkExe = 'AutoHotKey'
$ahkProcess = "$ahkExe '$scriptPath\sim-install.ahk'"

if (-not (Test-Path $filePath)) {
    New-Item $filePath -type directory
}

Get-ChocolateyWebFile $packageName $fileFullPath $url
Start-Process $fileFullPath -ArgumentList "/s" -Wait
Start-ChocolateyProcessAsAdmin $ahkProcess

$dontQuit = $true
do {
    Start-Sleep -Seconds 1
    $process = Get-Process | `
        ? {$_.mainWindowTItle.Contains("Installing Sitecore Instance Manager (SIM)") } | `
        ? {$_.ProcessName -eq "dfsvc"}
    $dontQuit = $process -ne $null
} while ($dontQuit)