$appPathKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\2db4ca814b8890e3"
if (Test-Path $appPathKey) {
    $entry = gi $appPathKey
    $entry.GetValue("DisplayVersion")
    $entry.GetValue("DisplayName")

    $scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
    $ahkExe = 'AutoHotKey'
    $ahkProcess = "$ahkExe '$scriptPath\sim-uninstall.ahk'"

    try {
        $uninst = $entry.GetValue("UninstallString")
        $index = $uninst.IndexOf(" ")
        $exe = $uninst.Substring(0, $index)
        $argz = $uninst.Substring($index, $uninst.Length - $index)
        Start-Process $exe $argz
        Start-ChocolateyProcessAsAdmin $ahkProcess
        Write-ChocolateySuccess $packageName
    }
    catch {
        Write-ChocolateyFailure $packageName "Erorro while unisntalling."
    }
}
else {
    Write-ChocolateyFailure $packageName "Nothing to uninstall."
}