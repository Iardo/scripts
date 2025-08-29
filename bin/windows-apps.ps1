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

function List_Check {}
function List_Make {}
function List_Delete {}

function Download {
    param ($app)
    $out_path = '.\\cache\\' + $app.file

    Write-Host '- ' $app.name
    Start-BitsTransfer -Source $app.url -Destination $out_path
}

function Downloads {
    param ($app_list)
    $out_path = '.\\'

    Makedir $out_path
    Write-Host 'Downloading:'
    foreach ($item in $app_list) {
        Download $item
    }
}

function Makedir {
    param ($out_path)
    New-Item -Path $out_path -ItemType Directory -Force | Out-Null
}

function Pressanykey {
    Write-Host "`nPress any key to finish the process..."
    $char = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeydown")
}

# -------------------- #
function List_Downloads {
    Downloads @(
        [PsCustomObject]@{
            name = "Discord"
            file = "discord-latest.exe"
            url  = "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x64"
        }
        [PsCustomObject]@{
            name = "Free Download Manager"
            file = "fdm-latest.exe"
            url  = "https://files2.freedownloadmanager.org/6/latest/fdm_x64_setup.exe"
        }
        [PsCustomObject]@{
            name = "Icaros"
            file = "icaros-3.3.4b1.exe"
            url  = "https://github.com/Xanashi/Icaros/releases/download/v3.3.4b1/Icaros_v3.3.4_b1.exe"
        }
        [PsCustomObject]@{
            name = "Imgbrd Grabber"
            file = "imgbrd-grabber-7.13.0.exe"
            url  = "https://github.com/Bionus/imgbrd-grabber/releases/download/v7.13.0/Grabber_v7.13.0_x64.exe"
        }
        [PsCustomObject]@{
            name = "Wezterm"
            file = "wezterm-20240203-110809-5046fc22.exe"
            url  = "https://github.com/wezterm/wezterm/releases/download/20240203-110809-5046fc22/WezTerm-20240203-110809-5046fc22-setup.exe"
        }
        [PsCustomObject]@{
            name = "XNViewMP"
            file = "xnviewmp-latest.exe"
            url  = "https://www.xnview.com/download.php?file=XnViewMP-win-x64.exe"
        }
    )
}

function Makedirs {
    Makedir $(".\\cache")
}

# -------------------- #
# Self_Elevate
Makedirs
List_Downloads
Pressanykey
