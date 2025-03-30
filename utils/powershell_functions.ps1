# ANSI Color codes using escape sequences (works in most modern terminals)
$Esc = [char]27
$Reset = "${Esc}[0m"
$Bold = "${Esc}[1m"
$Red = "${Esc}[31m"
$RedBr = "${Esc}[1;31m"
$RedLt = "${Esc}[91m"
$Grn = "${Esc}[32m"
$GrnBr = "${Esc}[1;32m"
$GrnLt = "${Esc}[92m"
$Blu = "${Esc}[34m"
$BluBr = "${Esc}[1;34m"
$BluLt = "${Esc}[94m"
$Ylw = "${Esc}[1;33m"

function Test-ColorCodes {
    Write-Host "${Red}Test text to test color code${Reset}"
    Write-Host "${RedBr}Test text to test color code${Reset}"
    Write-Host "${RedLt}Test text to test color code${Reset}"
    Write-Host "${Grn}Test text to test color code${Reset}"
    Write-Host "${GrnBr}Test text to test color code${Reset}"
    Write-Host "${GrnLt}Test text to test color code${Reset}"
    Write-Host "${Blu}Test text to test color code${Reset}"
    Write-Host "${BluBr}Test text to test color code${Reset}"
    Write-Host "${BluLt}Test text to test color code${Reset}"
    Write-Host "${Ylw}Test text to test color code${Reset}"
    Write-Host "${Bold}Test text to test color code${Reset}"
}

function Print-Debug($msg) {
    Write-Host "[${BluLt}DBUG${Reset}] $msg"
}

function Print-Info($msg) {
    Write-Host "[${Bold}${Grn}INFO${Reset}] $msg"
}

function Print-Warn($msg) {
    Write-Host "[${Bold}${Ylw}WARN${Reset}] $msg"
}

function Print-Err($msg) {
    Write-Host "[${Bold}${Red}ERRO${Reset}] $msg"
}