<#
 Author:       Iván Ramos
 Author Mail:  iardoru@gmail.com
 License:      
 License URI:  
#>

$script      = "C:\Scripts\bin\windows-startup.ps1"
$task_name   = 'Startup Window Manager'
$task_desc   = 'Runs startup.ps1 at user logon.'
$task_user   = [Environment]::MachineName + '\' + $env:UserName
$cfg_general = New-ScheduledTaskPrincipal -UserID $task_user -RunLevel Limited
$cfg_action  = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument $('-NoProfile -ExecutionPolicy Bypass -File ' + $script)
$cfg_trigger = New-ScheduledTaskTrigger -AtLogon -User $task_user
$cfg_setting = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd

if (-Not (Get-ScheduledTask -TaskName $task_name -ErrorAction SilentlyContinue)) {
    Write-Host $task_name '... ' -NoNewline
    Register-ScheduledTask -TaskName $task_name -Description $task_desc -Principal $cfg_general -Trigger $cfg_trigger -Action $cfg_action -Settings $cfg_setting | Out-Null
    Write-Host 'done'
}
