<#
###################
AD PORT SCRIPT
###################
This AD port script checks all of the relevant AD ports that can be found via the technet article (https://technet.microsoft.com/en-us/library/dd772723(v=ws.10).aspx)
This does NOT apply to communication between RODC and a writeable DC as this requires additional ports.
###################
#>

Function Test-ADPorts($IP, [switch]$ADPorts, $Ports) {
If ($ADPorts) {
    If ($Ports) {
        $Ports = 389,636,3268,3269,88,53,445,25,135,5722,464,9389,139
        }
    Else {
        $Ports = 389,636,3268,3269,88,53,445,25,135,5722,464,9389,139
        }
    }
    ForEach ($Port in $Ports) {
    Try {
        New-Object Net.Sockets.TcpClient $IP,$port | Out-Null
        Write-Host "TCP Port $Port on $IP is contactable from $env:COMPUTERNAME"
        }
        Catch {
            Write-Host "TCP Port $Port on $IP is NOT contactable from $env:COMPUTERNAME"
            }
     }
     }

Test-ADPorts <# Remote hostname/IP goes here i.e. [Server1] or [192.168.5.10] #> -ADPorts