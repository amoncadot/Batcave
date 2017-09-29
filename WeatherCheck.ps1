### Commands used below to help build the script 

### get-help Invoke-WebRequest -Examples
### get-help Write-Progress  -Examples

# Wrap the script in a function so it can be called using one cmdlet
function Start-WeatherCheck ($weather){

# Declare variable and get user to enter in the city
$weather = Read-Host -Prompt "Hello! Want to see today's forecast in your chosen city? Enter the city here"

# If the $weather contains no text, let the user know that nothing was entered and to retry showing an example answer
If ($weather -eq "")
    {

        Write-Host "No text entered. Please run the script and try again to enter a city from any part of the world 
        such as: Reading, Texas or Budapest."

    }

# Else if the user entered correctly, proceed to run the script
else{

# Confirm the selection
Write-Host "You have chosen $weather!"

# Show the selection for 3 seconds for better user experience
Start-Sleep -s 3

# Let the user know that if the script is paused, it is because it is loading
Write-Host "Please wait while we check the weather in $weather for you!"

#Show the loading time of the weather request
For ($loading = 1; $loading -le 100; $loading++)
{Write-Progress -Activity "Getting weather report for $weather..." -Status "$loading complete:" -PercentComplete $loading;}

#Get the latest weather report from the URL below
(Invoke-WebRequest -Uri http://wttr.in/$weather).ParsedHtml.body.OuterText 
          
}
}


######## RAN OUT OF TIME TO BUILD END PIECE OF SCRIPT WHICH ASKS IF THE USER WANTS TO CHECK ANOTHER CITY'S WEATHER #########

#region Ask the user if they want to check another city for weather

### If ($weather -contains $null){
           
### Write-Host "Would you like to enter another city?"

### $Readhost = Read-Host "Y / N"
### if($readhost -eq "y") {
                        ### Run start-weathercheck}

### else{

### Write-Host "Thank you for checking the weather today and dress appropriately!"

### }
### }

#endregion 
