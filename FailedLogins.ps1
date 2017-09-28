
#Wrap the code within a function so it is easier to run
Function FailedLogins{

#Number of hours to go back in event log
$Hours = "1"

#alert threshold, say it's 5 it will alert at 5 or above
$AlertThreshold = "5"

# Check if Event Log Source already exists
$path = Test-Path -path "HKLM:\SYSTEM\CurrentControlSet\services\eventlog\Application\LoginFailure"

if ($path -eq $false) {
# If Event Log Source does not exist then create it
[System.Diagnostics.EventLog]::CreateEventSOurce("LoginFailure","Application")
}

$MinusHours = (get-date).AddHours(-$Hours)
$Event = Get-EventLog -LogName Security 4625 -after $MinusHours
$MeasuredEvents = $Event | measure-object
$Count = $MeasuredEvents.Count

# If the Count....
if ($Count -lt $AlertThreshold)
 {
    # ..is less than the alert threshold then Write to the Application Log under Event ID 667 & source "LoginFailure" that the login failures are < 5 
    write-host "under alert threshold"
    Write-EventLog -LogName Application -source LoginFailure -EventId 667 -EntryType Information -Message "$Count login failures in the last $AlertThreshold hours";
    Write-Host "$Count login failures in the last $AlertThreshold hours"
}
else
{
    # ..is over the alert threshold then write to the Application Log under Event ID 668 & source "LoginFailure" that the login failures are > 5
    write-host "over the alert threshold"
    Write-EventLog -LogName Application -source LoginFailure -EventId 668 -EntryType Error -Message "$Count login failures in the last $AlertThreshold hours";
    Write-Host "$Count login failures in the last $AlertThreshold hours"
}
}