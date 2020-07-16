Write-Output "--- system details"
$Properties = 'Caption', 'CSName', 'Version', 'BuildType', 'OSArchitecture'
Get-CimInstance Win32_OperatingSystem | Select-Object $Properties | Format-Table -AutoSize

$ErrorActionPreference = 'Stop'

Write-Output "--- Enable Ruby 2.7"
Write-Output "Add Uru to Environment PATH"
$env:PATH = "C:\Program Files (x86)\Uru;" + $env:PATH
[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

Write-Output "Register Installed Ruby Version 2.7 With Uru"
Start-Process "C:\Program Files (x86)\Uru\uru_rt.exe" -ArgumentList 'admin add C:\ruby27\bin' -Wait
uru 271
if (-not $?) { throw "Can't Activate Ruby. Did Uru Registration Succeed?" }

Write-Output "+++ bundle install"
bundle config --local path vendor/bundle
bundle install --jobs=7 --retry=3

Write-Output "+++ bundle exec rake spec"
bundle exec rake spec
if (-not $?) { throw "mixlib-shellout specs failing." }