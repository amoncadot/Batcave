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
$ComputerSystem = Get-WmiObject -ComputerName $ComputerName -Class Win32_operatingsystem -Property CSName, TotalVisibleMemorySize, FreePhysicalMemory# Get just the machine name from the gwmi query$MachineName = $ComputerSystem.CSName# Get the free physical memory and convert from KB to GB$FreePhysicalMemory = ($ComputerSystem.FreePhysicalMemory) / (1mb)# Get the total visible memory and convert from KB to GB$TotalVisibleMemorySize = ($ComputerSystem.TotalVisibleMemorySize) / (1mb)# {0:N2} standard numeric formatting so that the output does not show multiple 0s$TotalVisibleMemorySizeR = “{0:N2}” -f $TotalVisibleMemorySize# Divide free physical memory by total visible memory size$TotalFreeMemPerc = ($FreePhysicalMemory/$TotalVisibleMemorySize)*100# Show the total free memory in standard format so it is easy to read$TotalFreeMemPercR = “{0:N2}” -f $TotalFreeMemPerc# Show the hostnameWrite-Host “`nServer: $MachineName”# Show the date/timeWrite-Host "Date:" (Get-Date)# Show the total amount of GB on the systemWrite-Host “RAM installed: $TotalVisibleMemorySizeR GB”# Show the free physical memory Write-Host “Free RAM available: $TotalFreeMemPercR %`n`r”}# Run the function aboveGet-MemoryUsage# Title the table that will be producedWrite-Host "Processes using more than 100MB of memory now:"# Check how much memory is being used by which process and show processes using > 100MBGet-Process | Where-Object {$_.pm -gt 100MB} | Sort-Object pm -Descending | 
Select-Object name,@{n="Mem(MB)";e={"{0:N2}" -f ($_.pm / 1MB)}} | Format-Table -AutoSize 