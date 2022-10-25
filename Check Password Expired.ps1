# Get our list of user names from the local file
$users = Get-Content 'C:\Scripts\username.txt'

# Create log file of output:
$ReportDate = Get-Date -Format 'MM-dd-yyyy_hh-mm-ss'
$ReportPath = "C:\Scripts\"
$Report = $ReportPath + "PasswordExpiredReport_" + $ReportDate + ".txt"
New-Item -path $Report -type File

foreach ($user in $users) {
"Checking user: $user" | out-file $Report -Append #Notify user checked
net user $user /domain | select-string 'Account active' >> $Report #Obtain user information using net user, select only Account Active
net user $user /domain | select-string 'Password expires' >> $Report #Obtain user information using net user, select only Password Expired
Start-Sleep -Second 3 #Pause to let system gather information
}
