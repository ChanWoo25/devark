# Check PowerShell version
$PSMajor = $PSVersionTable.PSVersion.Major
$PSMinor = $PSVersionTable.PSVersion.Minor

if ($PSMajor -lt 7) {
  Write-Host "This script requires PowerShell 7 or higher. (current shell: ${PSMajor}.${PSMinor}.x)"
  Write-Host ""
  Write-Host "[Powershell 7 Installation guide here]"
  Write-Host "1.  latest  version: winget install --id Microsoft.PowerShell --source winget"
  Write-Host "2. specific version: winget install --id Microsoft.PowerShell --source winget --version 7.4.5.0"
  Write-Host ""
  Write-Host "Check more detail about powershell from 'https://github.com/PowerShell/PowerShell/releases'"
  Write-Host "After installing, run this script again using 'pwsh' instead of 'powershell'. "
  Write-Host "Or just open powershell 7 terminal and run this script again."
  exit 1
}

$ScriptDir = Split-Path -Parent ${MyInvocation}.MyCommand.Path
$ScriptPath = ${MyInvocation}.MyCommand.Path
# Write-Host "ScriptDir: ${ScriptDir}"
# Write-Host "ScriptDir: ${ScriptPath}"

. "$ScriptDir\utils\powershell_functions.ps1"

# Ctrl+C handling
$interrupted = {
    Print-Warn "Interrupted by user $env:USERNAME..."
    exit 1
}
$cleanup = {
    Write-Host "Cleaning up before exit..."
}
# Register cleanup handlers
$null = Register-EngineEvent PowerShell.Exiting -Action $cleanup
$null = Register-EngineEvent Console.CancelKeyPress -Action $interrupted

function Initialize {
    Print-Debug "SCRIPT_DIR: $ScriptDir"
    Print-Debug "SCRIPT_PATH: $ScriptPath"
}

Write-Host "${Grn}
┌───────────────────────────────────────────────────┐
│ ██████╗ ███████╗██╗   ██╗ █████╗ ██████╗ ██╗  ██╗ │
│ ██╔══██╗██╔════╝██║   ██║██╔══██╗██╔══██║██║ ██╔╝ │
│ ██║  ██║█████╗  ██║   ██║███████║██████╚╗█████╔╝  │
│ ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══██║██╔═╗██║██╔═██╗  │
│ ██████╔╝███████╗ ╚████╔╝ ██║  ██║██║ ║██║██║  ██╗ │
│ ╚═════╝ ╚══════╝  ╚═══╝  ╚═╝  ╚═╝╚═╝ ╚══╝╚═╝  ╚═╝ │
└───────────────────────────────────────────────────┘
${Reset}"

Initialize

Print-Info "◇ Install UV Manager"
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
  Print-Info "  ◆ Not found. Installing..."
  Write-Host ''
  Write-Host '────────── WORK ──────────'
  powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
  Write-Host '────────── DONE ──────────'
  Write-Host ''
}
else {
  Print-Info "  ◆ Already installed."
}

# Add autocompletion for uv
if (!(Test-Path -Path $PROFILE)) {
  New-Item -ItemType File -Path $PROFILE -Force
}
Add-Content -Path $PROFILE -Value '(& uv generate-shell-completion powershell) | Out-String | Invoke-Expression'