<#
 Author:       Iván Ramos
 Author Mail:  iardoru@gmail.com
 License:      
 License URI:  
#>

# Self-Elevated Privileges
function Self_Elevate {
    $current_user = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-Not ($current_user.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
        if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
            $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
            Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
            Exit
        }
    }
}

function Makedir {
    param ($out_path)
    New-Item -Path $out_path -ItemType Directory -Force | Out-Null
}

function Makelink {
    param ($src_path, $out_path)
    if (-Not (Test-Path $src_path)) {
        Write-Host "Path: `"$src_path`" does not exist."
        Exit
    }
    if (-Not (Test-Path $out_path)) {
        New-Item -ItemType SymbolicLink -Path $out_path -Target $src_path | Out-Null
    }
}

function Pressanykey {
    Write-Host "`nPress any key to finish the process..."
    $char = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeydown")
}

# -------------------- #
$dotfiles = "C:\Dotfiles"
$userpath = $HOME

function Makedirs {
    Makedir $($userpath + "\.config")
    Makedir $($userpath + "\.glzr")
}

function Makelinks {
    Makelink $($dotfiles + "\config\app\glazewm")                     $($userpath + "\.glzr\glazewm")
    Makelink $($dotfiles + "\config\app\komorebi\komorebi.bar.json")  $($userpath + "\komorebi.bar.json")
    Makelink $($dotfiles + "\config\app\komorebi\komorebi.json")      $($userpath + "\komorebi.json")
    Makelink $($dotfiles + "\config\app\mpv")                         $($userpath + "\AppData\Roaming\mpv")
    Makelink $($dotfiles + "\config\app\ueli\ueli9.settings.json")    $($userpath + "\AppData\Roaming\ueli\ueli9.settings.json")
    Makelink $($dotfiles + "\config\app\wezterm")                     $($userpath + "\.config\wezterm")
    Makelink $($dotfiles + "\config\app\yasb")                        $($userpath + "\.config\yasb")
}

# -------------------- #
Self_Elevate
Makedirs
Makelinks
Pressanykey
