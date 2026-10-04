$service = Get-Service -Name wuauserv | Select-Object name, status

if($service.status -like "stopped"){

    write-host "Service is stopped."
    
        } else {

            Write-Host "Service on"

            }

$process = get-process | Where-Object {$_.WorkingSet -gt 500MB} | 
select-object processname, id -First 10

$layout = foreach($proc in $process){

        $info = Get-CimInstance win32_process -Filter "ProcessID = $($proc.Id)" | 
        select-object processname, commandline, executablepath
        $tcp = Get-NetTCPConnection | 
        where-object {$_.OwningProcess -like "$($proc.id)" -or $_.state -like "Listen"} | 
        select-object state, owningprocess
        $logs = Get-WinEvent system | 
        where-object {$_.leveldisplayname -like "Error" -or $_.leveldisplayname -like "warning" -and $_.timecreated -gt (Get-Date).AddDays(-1)} | 
        select-object timecreated, id, leveldisplayname -First 5

        $investigate1 = Get-CimInstance win32_process -Filter "processid = 35892" | 
        Select-Object commandline, executablepath, processname
        $investogate2 = Get-CimInstance win32_process -filter "processid = 27724" | 
        select-object commandline, executablepath, processname
        $systemuptime = (Get-CimInstance win32_operatingsystem).LastBootUpTime 
        $topProcess = get-process | where-object {$_.cpu -gt 200 -and $_.WorkingSet64 -gt 200MB} | 
        select-object processname, cpu, workingset64 -First 5 | Sort-Object -Descending

    [PSCustomObject]@{

        PROCESSNAME = $proc.ProcessName

        COMMANDLINE = $info.commandline

        EXECUTABLEPATH = $info.executablepath

        TCP = $tcp

        LOGS = $logs

        Proc35892 = $investigate

        Proc27724 = $investogate2

        systemlastbootup = $systemuptime

        Topprocess = $topProcess

        }
}



$layout | Format-List
