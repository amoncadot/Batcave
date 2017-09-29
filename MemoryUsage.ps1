﻿<#
###################
MEMORY CHECK SCRIPT
###################
This script checks the hostname, date/time, RAM, free RAM and processes usign 100MB of memory at present.
You can copy this script and just run it onto any system and it will produce an output like so:

Server: Server1
Date: 29/09/2017 15:24:30
RAM: 7.66 GB
Free Physical Memory: 15.52 %

Processes using more than 100MB of memory now:

Name           Mem(MB) 
----           ------- 
chrome         1,199.91
chrome         478.30  
chrome         395.61  
chrome         379.05  
Spotify        371.84  

###################
#>

# Show top 10 processes consuming > 100MB of memory
Function Get-MemoryUsage {
# Get the server name, free memory and total memory (KB)
$ComputerSystem = Get-WmiObject -ComputerName $ComputerName -Class Win32_operatingsystem -Property CSName, TotalVisibleMemorySize, FreePhysicalMemory
Select-Object name,@{n="Mem(MB)";e={"{0:N2}" -f ($_.pm / 1MB)}} | Format-Table -AutoSize 