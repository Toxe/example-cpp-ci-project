# Install Vcpkg in $HOME\vcpkg or update an already existing installation.
#
# Usage: .ci\install-vcpkg.ps1

$ErrorActionPreference = "Stop"

$VCPKG_DIR = "$HOME\vcpkg"

# either install Vcpkg or update an existing installation
if (Test-Path "$VCPKG_DIR" -PathType Container)
{
    $UPDATE_VCPKG = 1
}
else
{
    $UPDATE_VCPKG = 0
}

Write-Host "---- install-vcpkg.ps1 ----"
Write-Host "Vcpkg install directory: $VCPKG_DIR"
Write-Host "Update existing Vcpkg? $UPDATE_VCPKG"
Write-Host "---------------------------"

if (-not(Get-Command git -ErrorAction SilentlyContinue))
{
    New-Alias -Name git -Value "$Env:ProgramFiles\Git\bin\git.exe"
}

if ($UPDATE_VCPKG)
{
    # update existing Vcpkg
    Push-Location "$VCPKG_DIR"
    git pull
    .\bootstrap-vcpkg.bat -disableMetrics
    Pop-Location
}
else
{
    # install Vcpkg
    Push-Location "$HOME"
    git clone --quiet https://github.com/Microsoft/vcpkg.git
    Set-Location vcpkg
    .\bootstrap-vcpkg.bat -disableMetrics
    Pop-Location
}
