<#
###################
PORT EXHAUSTION SCRIPT
###################
This script checks the hostname, date/time, number of ESTABLISHED, TIME_WAIT & CLOSE_WAIT connections and display them in an output.
The IF statement allows you to configure a certain amount of CLOSE_WAIT connections as a threshold so that you are prompted with remediation methods.

You can copy this script and just run it onto any system and it will produce an output like so:

Server: CORP-L-17-1016
Date: 10/02/2017 11:45:27
Number of ESTABLISHED connections: 23
Number of TIME_WAIT connections: 0
Number of CLOSE_WAIT connections: 0

Amount of CLOSE_WAIT connections is higher than 0 ( 0 ). Please consider checking the following: 

 1. Check the TCPTIMEDWAITDELAY reg key config to confirm the threshold under HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters, default should be 2 or
 4 minutes (Info: https://technet.microsoft.com/en-us/library/cc938217.aspx)

 2. Confirm if there is a load balancer or application gateway and ensure that the config has a low threshold to close connections.

 3. If the server hosts a website you can check IIS or Apache to determine how the close connection setting has been configured. Please confirm with the cust
omer before making any changes.

###################
#>

Function Port-Exhaustion{
$date = Get-Date
$timewait = netstat -ano | findstr "TIME_WAIT" | Measure-Object
$established = netstat -ano | findstr "ESTABLISHED" | Measure-Object
$closewait = netstat -ano | findstr "CLOSE_WAIT" | Measure-Object

Write-Host "Server: $env:COMPUTERNAME"
Write-Host "Date: $Date"
Write-Host "Number of ESTABLISHED connections:"$established.Count
Write-Host "Number of TIME_WAIT connections:"$timewait.Count
Write-Host "Number of CLOSE_WAIT connections:"$closewait.Count

If ($closewait.Count -ge 0)
    {
        Write-Host "`nAmount of CLOSE_WAIT connections is higher than 0 (" $closewait.Count "). Please consider checking the following: "

        "`n 1. Check the TCPTIMEDWAITDELAY reg key config to confirm the threshold under HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters, default should be 2 or 4 minutes (Info: https://technet.microsoft.com/en-us/library/cc938217.aspx)"
        "`n 2. Confirm if there is a load balancer or application gateway and ensure that the config has a low threshold to close connections."
        "`n 3. If the server hosts a website you can check IIS or Apache to determine how the close connection setting has been configured. Please confirm with the customer before making any changes."
        }
        else{}
}
