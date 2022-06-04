# Install Vcpkg in $HOME\vcpkg.
#
# Usage: .ci\install-vcpkg.ps1

$ErrorActionPreference = "Stop"

Write-Host "---- install-vcpkg.ps1 ----"
Write-Host "Vcpkg install directory: $HOME\vcpkg"
Write-Host "---------------------------"

if (-not(Get-Command git -ErrorAction SilentlyContinue))
{
    New-Alias -Name git -Value "$Env:ProgramFiles\Git\bin\git.exe"
}

Push-Location "$HOME"
git clone https://github.com/Microsoft/vcpkg.git
Set-Location vcpkg
.\bootstrap-vcpkg.bat -disableMetrics
Pop-Location
