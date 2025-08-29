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
Start-Process -FilePath $taskbar
Start-Process -FilePath $windows
Start-Process -FilePath $launcher
Start-Process -FilePath $winxmove
