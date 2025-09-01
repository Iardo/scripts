<#
 Author:       Iván Ramos
 Author Mail:  iardoru@gmail.com
 License:      
 License URI:  
#>

$taskbar  = "C:\Program Files\yasb\yasb.exe"
$windows  = "C:\Program Files\glzr.io\GlazeWM\glazewm.exe"
$launcher = "C:\Program Files\ueli\Ueli.exe"
$winxmove = "C:\Program Files\win-x-move\1.1\winxmove.exe"

# -------------------- #
if (-Not (Get-Process -Name "yasb" -ErrorAction SilentlyContinue)) {
    Start-Process -FilePath $taskbar
}
if (-Not (Get-Process -Name "glazewm" -ErrorAction SilentlyContinue)) {
    Start-Process -FilePath $windows
}
if (-Not (Get-Process -Name "Ueli" -ErrorAction SilentlyContinue)) {
    Start-Process -FilePath $launcher
}
if (-Not (Get-Process -Name "winxmove" -ErrorAction SilentlyContinue)) {
    Start-Process -FilePath $winxmove
}
