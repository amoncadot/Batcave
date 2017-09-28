#region Declare variables: Removal date, directory to delete and credentials to send the e-mail
$removaldate = (Get-Date).AddDays(-7) 
$dir = Read-Host "Enter the root location of files you wish to delete"
$creds = Get-Credential 
#endregion 

#region Create the function to: Delete the files, wrap it into a .txt file and send it using SSL
Function CleanUp-Files 
{Out-String; Get-ChildItem $dir -file -Recurse | Where {$_.Name -match “*.log” -and $_.CreationTime -le $removaldate}  | Remove-Item -Verbose |
Psdrive | where {$_.Name -eq "C"} | ft -a | Out-File C:\test\results.txt | 
Send-MailMessage -To "Spotlight Test <test@example.com>" -From "Alex Gmail <amoncadot@gmail.com" -Subject "2 Hour test" -Body "Please review the results.txt file" -Attachments "C:\test\results.txt" -SmtpServer "smtp.example.com" -Credential $creds -UseSsl}
#endregion 



SEPARATE SCRIPT  BELOW:

#region Network Scripting
$email = Read-Host "Enter your e-mail address"

Function E-mail 
{Test-Connection smtp-relay.gmail.com | ft -a | Write-Output "List of relay servers for $email"}
#endregion 
