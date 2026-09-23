# Scenario: "My Internet is Broken & I Can't Print"

$Flushdns = Clear-DnsClientCache
$ResetAdapter = Restart-NetAdapter -Name "thewifi"
$TestPrinter = ping 192.168.1.250
$TestPrinterConnection = Test-NetConnection -port 9100
$dhcpReset = ipconfig /release 
$DHcpReset2b= ipconfig /renew



# Scenario: The "Unauthorized Local Admin" Security Alert

$Getallcurrentusers = Get-LocalUser
$getUserProvelage = get-localgroupmember -Group administrators
$disablebackdoor = Disable-LocalUser -Name "backdoor_user"
$checkforoutboundconn = Get-process -IncludeUserName "backdoor"
$checkforopenconn = Get-NetTCPConnection -OwningProcess $checkforoutboundconn.name


# Scenario: The Persistent "Ghost Process" Ransomware Indicator

$Finmalisousprocess = Get-NetTCPConnection | where-object {$_.RemoteAddress -eq "198.51.100.44"}
$findtheprocessrelatedtotheip = get-process -id $Finmalisousprocess.OwningProcess -IncludeUserName | Select-Object -Property Name, ID, Path
$getschaduledtasks = Get-ScheduledTask | where-object {$_.TaskPath -eq $env:TEMP -or $_.TaskPath -eq $env:APPDATA -or$_.TaskPath -eq "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"}
$NewFireWallRuleToBlock = New-NetFirewallRule -DisplayName Block_Malisious_IP -Description "Malisious IP Address Block Rule" -RemoteAddress 198.51.100.44 -Action Block 