$processes = Get-CimInstance win32_process | select-object -Property processid, 

parentprocessid, 

processname, 

Executablepath,

commandline

$layout = foreach($proc in $processes){

        $risklevel = "Low"

    if($proc.Executablepath -like "*temp*"){

        write-host "suspisous process" -ForegroundColor Yellow

        $risklevel = "med"

        }

    if($proc.commandline -like "*EncodedCommand*"){

        Write-Host "suspisous command line" -ForegroundColor Red

        $risklevel = "high"
        }


         [PSCustomObject]@{

    Processid = $proc.processid

    parentprocess = $proc.parentprocessid

    processname = $proc.ProcessName

    executablepath = $proc.Executablepath

    commandline = $proc.commandline

    risklevel = $risklevel

    }

}


$layout | Out-GridView
